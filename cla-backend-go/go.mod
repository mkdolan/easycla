// Copyright The Linux Foundation and each contributor to CommunityBridge.
// SPDX-License-Identifier: MIT
module github.com/communitybridge/easycla/cla-backend-go

go 1.16

replace github.com/awslabs/aws-lambda-go-api-proxy => github.com/LF-Engineering/aws-lambda-go-api-proxy v0.3.2

require (
	github.com/LF-Engineering/aws-lambda-go-api-proxy v0.3.2
	github.com/LF-Engineering/lfx-kit v0.1.25
	github.com/LF-Engineering/lfx-models v0.6.44
	github.com/aws/aws-lambda-go v1.22.0
	github.com/aws/aws-sdk-go v1.36.27
	github.com/aymerick/raymond v2.0.2+incompatible
	github.com/bitly/go-simplejson v0.5.0 // indirect
	github.com/bmizerany/assert v0.0.0-20160611221934-b7ed37b82869
	github.com/bradleyfalzon/ghinstallation v1.1.1
	github.com/coreos/bbolt v1.3.2 // indirect
	github.com/coreos/etcd v3.3.13+incompatible // indirect
	github.com/coreos/go-systemd v0.0.0-20190321100706-95778dfbb74e // indirect
	github.com/coreos/pkg v0.0.0-20180928190104-399ea9e2e55f // indirect
	github.com/cpuguy83/go-md2man/v2 v2.0.1 // indirect
	github.com/davecgh/go-spew v1.1.1
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/fnproject/fdk-go v0.0.2
	github.com/gin-gonic/gin v1.7.2
	github.com/go-delve/delve v1.7.0 // indirect
	github.com/go-openapi/errors v0.19.6
	github.com/go-openapi/loads v0.19.5
	github.com/go-openapi/runtime v0.19.19
	github.com/go-openapi/spec v0.19.8
	github.com/go-openapi/strfmt v0.19.5
	github.com/go-openapi/swag v0.19.9
	github.com/go-openapi/validate v0.19.10
	github.com/go-playground/validator/v10 v10.7.0 // indirect
	github.com/go-resty/resty/v2 v2.3.0
	github.com/gofrs/uuid v4.0.0+incompatible
	github.com/golang/mock v1.6.0
	github.com/google/go-github/v37 v37.0.0
	github.com/google/uuid v1.1.4
	github.com/gorilla/sessions v1.2.1 // indirect
	github.com/gorilla/websocket v1.4.2 // indirect
	github.com/grpc-ecosystem/go-grpc-middleware v1.0.0 // indirect
	github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0 // indirect
	github.com/imroc/req v0.3.0
	github.com/jessevdk/go-flags v1.4.0
	github.com/jinzhu/copier v0.0.0-20190924061706-b57f9002281a
	github.com/jmoiron/sqlx v1.2.0
	github.com/jonboulle/clockwork v0.1.0 // indirect
	github.com/juju/mempool v0.0.0-20160205104927-24974d6c264f // indirect
	github.com/juju/zip v0.0.0-20160205105221-f6b1e93fa2e2
	github.com/kr/pretty v0.2.0 // indirect
	github.com/leodido/go-urn v1.2.1 // indirect
	github.com/mattn/go-colorable v0.1.8 // indirect
	github.com/mattn/go-isatty v0.0.13 // indirect
	github.com/mattn/go-runewidth v0.0.13 // indirect
	github.com/mitchellh/go-homedir v1.1.0 // indirect
	github.com/mitchellh/mapstructure v1.4.1
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/mozillazg/request v0.8.0 // indirect
	github.com/myitcv/gobin v0.0.14 // indirect
	github.com/pdfcpu/pdfcpu v0.3.5-0.20200802160406-be1e0eb55afc
	github.com/peterh/liner v1.2.1 // indirect
	github.com/pkg/profile v0.0.0-20170413231811-06b906832ed0 // indirect
	github.com/prometheus/client_golang v0.9.3 // indirect
	github.com/rogpeppe/go-internal v1.8.0 // indirect
	github.com/rs/cors v1.7.0
	github.com/savaki/dynastore v0.0.0-20171109173440-28d8558bb429
	github.com/shurcooL/githubv4 v0.0.0-20201206200315-234843c633fa
	github.com/shurcooL/graphql v0.0.0-20200928012149-18c5c3165e3a // indirect
	github.com/sirupsen/logrus v1.8.1
	github.com/soheilhy/cmux v0.1.4 // indirect
	github.com/spf13/cobra v1.2.1
	github.com/spf13/viper v1.8.1
	github.com/stretchr/testify v1.7.0
	github.com/tencentyun/scf-go-lib v0.0.0-20200116145541-9a6ea1bf75b8
	github.com/tmc/grpc-websocket-proxy v0.0.0-20190109142713-0ad062ec5ee5 // indirect
	github.com/ugorji/go v1.2.6 // indirect
	github.com/verdverm/frisby v0.0.0-20170604211311-b16556248a9a
	github.com/xanzy/go-gitlab v0.50.1
	github.com/xiang90/probing v0.0.0-20190116061207-43a291ad63a2 // indirect
	go.etcd.io/bbolt v1.3.2 // indirect
	go.starlark.net v0.0.0-20210602144842-1cdb82c9e17a // indirect
	go.uber.org/ratelimit v0.1.0
	golang.org/x/arch v0.0.0-20210727222714-28578f966459 // indirect
	golang.org/x/crypto v0.0.0-20210711020723-a769d52b0f97 // indirect
	golang.org/x/image v0.0.0-20210628002857-a66eb6448b8d // indirect
	golang.org/x/net v0.0.0-20210726213435-c6fcb2dbf985
	golang.org/x/oauth2 v0.0.0-20210628180205-a41e5a781914
	golang.org/x/sync v0.0.0-20210220032951-036812b2e83c
	golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c // indirect
	golang.org/x/time v0.0.0-20200630173020-3af7569d3a1e
	google.golang.org/protobuf v1.27.1 // indirect
	gopkg.in/resty.v1 v1.12.0 // indirect
)
