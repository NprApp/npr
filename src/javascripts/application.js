require('./providers/store.js');
import HttpInterceptor from './services/http-interceptor.js';
import ApplicationController from './modules/application/controller.js';
import RootController from './modules/root/controller.js';
import LoginController from './modules/login/controller.js';
import LogoutController from './modules/logout/controller.js';
import AuthService from './services/auth.js';

angular.module('npr.app', [
  'ui.router',
  'ngResource',
  'ngAnimate',
  'restangular',
  'angular-cache',
  'underscore',
  'pg-data',
  // 'angular-modal',
  // 'app-filters',
  'ngCookies',
  '720kb.datepicker'
]);

angular.module('npr.app').config(
  function($stateProvider, $urlRouterProvider, $httpProvider, storeProvider) {
    $urlRouterProvider.otherwise('/login');
    $httpProvider.interceptors.push(HttpInterceptor);
    $httpProvider.useApplyAsync(true);
    storeProvider.setApp('npr.app');
    $stateProvider.state({
      name: 'root',
      url: '/',
      controller: RootController,
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
