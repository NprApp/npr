require('./providers/store.js');
require('./directives/modal/component.js');
require('./filters/base.js');
import HttpInterceptor from './services/http-interceptor.js';
import ApplicationController from './modules/application/controller.js';
import RootController from './modules/root/controller.js';
import LoginController from './modules/login/controller.js';
import LogoutController from './modules/logout/controller.js';
import SignUpController from './modules/sign_up/controller.js';
import AuthService from './services/auth.js';

angular.module('npr.app', [
  'ui.router',
  'ngResource',
  'ngAnimate',
  'restangular',
  'angular-cache',
  'underscore',
  'pg-data',
  'angular-modal',
  'app-filters',
  'ngCookies',
  '720kb.datepicker'
]);

angular.module('npr.app').config(
  function($stateProvider, $urlRouterProvider, $httpProvider) {
    $urlRouterProvider.otherwise('/login');
    $httpProvider.interceptors.push(HttpInterceptor);
    $httpProvider.useApplyAsync(true);
    $stateProvider.state({
      name: 'root',
      url: '/',
      controller: RootController,
      controllerAs: 'root',
      templateUrl: 'modules/root/template.html'
    });
    $stateProvider.state({
      name: 'login',
      url: '/login',
      controller: LoginController,
      templateUrl: 'modules/login/template.html'
    });
    $stateProvider.state({
      name: 'logout',
      url: '/logout',
      controller: LogoutController
    });
    $stateProvider.state({
      name: 'sign_up',
      url: '/sign_up',
      controller: SignUpController,
      controllerAs: 'vm',
      templateUrl: 'modules/sign_up/template.html'
    });
  }
);
angular.module('npr.app').controller('ApplicationController', ApplicationController);
angular.module('npr.app').service('auth', AuthService);
angular.module('npr.app').run(function($rootScope, auth) {
    $rootScope.$on('$stateChangeStart', function(event, toState) {
      auth.onStateChange(event, toState);
    });
  }
);
