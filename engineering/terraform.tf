variable "access_key" {
  description = "Your AWS Access Key"
}

variable "secret_key" {
  description = "Your AWS Secret Key"
}

variable "cidr" {
  default = "10.32.2.0/24"
}

provider "aws" {
  region     = "us-west-2"
  alias      = "local"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

terraform {
  backend "consul" {
    address = "consul.service.consul:8500"
    path    = "terraform/engineering"
  }
}

// This allows me to pull the state of another environment, in this case production-tools and grab data from it.
data "terraform_remote_state" "production-tools" {
  backend = "consul"
  config {
    address = "consul.service.consul:8500"
    path    = "terraform/production-tools"
  }
}

module "vpc" {
  source             = "../modules/vpc"
  name               = "Engineering"
  cidr               = "${var.cidr}"
  internal_subnets   = ["10.32.2.128/27", "10.32.2.160/27", "10.32.2.192/27"]
  external_subnets   = ["10.32.2.0/27",   "10.32.2.32/27",  "10.32.2.64/27"]
  availability_zones = ["us-west-2a",     "us-west-2b",     "us-west-2c"]
}

module "dhcp" {
  source  = "../modules/dhcp"
  name    = "engineering.internal"
  vpc_id  = "${module.vpc.id}"
  servers = "10.32.0.140, 10.32.0.180, 10.32.0.220"
}

module "security_groups" {
  source  = "./security_groups"
  cidr    = "${var.cidr}"
  vpc_id  = "${module.vpc.id}"
  name    = "Engineering"
}

module "jenkins" {
  source                 = "./jenkins"

  internal_subnets       = "${module.vpc.internal_subnets}"
  vpc_id                 = "${module.vpc.id}"
  sg_jenkins             = "${module.security_groups.jenkins_master}"
  sg_jenkins_efs         = "${module.security_groups.jenkins_master_efs}"
  sg_internal_elb        = "${module.security_groups.jenkins_master_elb}"
  region                 = "us-west-2"
}

module "sandboxes" {
  source                   = "./sandbox_cluster"

  region                   = "us-west-2"
  vpc_id                   = "${module.vpc.id}"
  internal_subnets         = "${module.vpc.internal_subnets}"
  external_subnets         = "${module.vpc.external_subnets}"
  availability_zones       = "${module.vpc.availability_zones}"
  sg_engineering_sandboxes = "${module.security_groups.engineering_sandboxes}"
  redis_sg                 = "${module.security_groups.engineering_sandboxes_redis}"
  internal_elb_sg          = "${module.security_groups.engineering_sandboxes_elb}"
}

module "peering" {
  source                    = "../modules/peering"

  vpc_id                    = "${module.vpc.id}"
  external_rtb_id           = "${module.vpc.external_rtb_id}"
  raw_route_tables_id       = "${module.vpc.raw_route_tables_id}"

  tools_account_number      = "${data.terraform_remote_state.production-tools.account_number}"
  tools_cidr                = "${data.terraform_remote_state.production-tools.west_cidr}"
  tools_vpc_id              = "${data.terraform_remote_state.production-tools.west_vpc_id}"
}

resource "aws_vpc_peering_connection" "peer" {
  provider      = "aws.local"

  peer_owner_id = "961082193871"
  peer_vpc_id   = "vpc-10c9f477"
  vpc_id        = "${module.vpc.id}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "peer_internal_1" {
  provider                  = "aws.local"
  route_table_id            = "${module.vpc.raw_route_tables_id[0]}"
  destination_cidr_block    = "10.31.0.0/23"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

resource "aws_route" "peer_internal_2" {
  provider                  = "aws.local"
  route_table_id            = "${module.vpc.raw_route_tables_id[1]}"
  destination_cidr_block    = "10.31.0.0/23"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

resource "aws_route" "peer_internal_3" {
  provider                  = "aws.local"
  route_table_id            = "${module.vpc.raw_route_tables_id[2]}"
  destination_cidr_block    = "10.31.0.0/23"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

resource "aws_route" "peer_external" {
  provider                  = "aws.local"
  route_table_id            = "${module.vpc.external_rtb_id}"
  destination_cidr_block    = "10.31.0.0/23"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

output "internal_subnets" {
  value = "${module.vpc.internal_subnets}"
}

output "external_subnets" {
  value = "${module.vpc.external_subnets}"
}

output "raw_route_tables_id" {
  value = "${module.vpc.raw_route_tables_id}"
}

output "sg_external_elb" {
  value = "${module.security_groups.engineering_sandboxes_elb}"
}

output "cidr" {
  value = "${var.cidr}"
}

output "vpc_id" {
  value = "${module.vpc.id}"
}
