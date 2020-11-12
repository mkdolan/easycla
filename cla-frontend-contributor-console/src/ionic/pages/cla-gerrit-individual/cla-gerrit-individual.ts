// Copyright The Linux Foundation and each contributor to CommunityBridge.
// SPDX-License-Identifier: MIT

import { Component } from '@angular/core';
import { NavController, NavParams, IonicPage } from 'ionic-angular';
import { ClaService } from '../../services/cla.service';
import { AuthService } from '../../services/auth.service';
import { Restricted } from '../../decorators/restricted';
import { generalConstants } from '../../constants/general';

@Restricted({
  roles: ['isAuthenticated']
})
@IonicPage({
  segment: 'cla/gerrit/project/:projectId/individual'
})
@Component({
  selector: 'cla-gerrit-individual',
  templateUrl: 'cla-gerrit-individual.html'
})
export class ClaGerritIndividualPage {
  projectId: string;
  project: any;
  gerrit: any;
  userId: string;
  user: any;
  signatureIntent: any;
  activeSignatures: boolean = true; // we assume true until otherwise
  signature: any;
  expanded: boolean = true;
  errorMessage: string;
  loading: boolean;

  constructor(
    public navCtrl: NavController,
    public navParams: NavParams,
    private claService: ClaService,
    private authService: AuthService,
  ) {
    this.getDefaults();
    this.projectId = navParams.get('projectId');
    localStorage.setItem('projectId', this.projectId);
    localStorage.setItem('gerritClaType', 'ICLA');
  }

  getDefaults() {
    this.project = {
      project_name: ''
    };
    this.signature = {
      sign_url: ''
    };
  }

  ngOnInit() {
    this.loading = true;
    this.authService.userProfile$.subscribe(user => {
      if (user !== undefined) {
        if (user) {
          this.getProject();
        } else {
          this.redirectToLogin();
        }
      }
    });
  }

  redirectToLogin() {
    this.navCtrl.setRoot('LoginPage');
  }

  getProject() {
    this.claService.getProjectWithAuthToken(this.projectId).subscribe(
      (project) => {
        this.project = project;
        localStorage.setItem(generalConstants.PROJECT_MODEL, JSON.stringify(project));
        // retrieve userInfo from auth0 service
        this.getUserDetails();
      },
      () => {
        this.loading = false;
        this.errorMessage = 'Invalid project id.';
      }
    );
  }

  getUserDetails() {
    this.claService.postOrGetUserForGerrit().subscribe(
      (user) => {
        this.userId = user.user_id;
        localStorage.setItem(generalConstants.USER_MODEL, JSON.stringify(user));
        // get signatureIntent object, similar to the Github flow.
        this.postSignatureRequest();
      },
      (exception) => {
        this.loading = false;
        this.errorMessage = 'Invalid user details, please login again.';
      }
    );
  }
  postSignatureRequest() {
    let signatureRequest = {
      project_id: this.projectId,
      user_id: this.userId,
      return_url_type: 'Gerrit'
    };
    this.claService.postIndividualSignatureRequest(signatureRequest).subscribe(
      (response) => {
        this.loading = false;
        this.signature = response;
      },
      () => {
        this.loading = false;
        this.errorMessage = 'Invalid signature.';
      }
    );
  }
 
  openClaAgreement() {
    if (!this.signature.sign_url) {
      return;
    }
    window.open(this.signature.sign_url, '_self');
  }

  onClickToggle(hasExpanded) {
    this.expanded = hasExpanded;
  }
}
