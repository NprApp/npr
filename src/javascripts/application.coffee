angular.module("npr.app",[
  "ui.router",
  "ngResource",
  "ngAnimate",
  "restangular",
  "angular-cache",
  "underscore",
  "angular-data",
  "angular-modal",
  "app-filters",
  # "ng-token-auth",
  "ngCookies",
  "720kb.datepicker"])
angular.module("npr.app").config [
  "$stateProvider",
  "$urlRouterProvider",
  "$httpProvider",
  # "$authProvider",
  ($stateProvider,  $urlRouterProvider, $httpProvider, $authProvider) ->
    $urlRouterProvider.otherwise('/')
    # $authProvider.configure
      # apiUrl: 'http://localhost:3000'

    $httpProvider.interceptors.push(["$cookies", ($cookies) ->
      request: (config) ->
        if !$cookies.xUserToken || !$cookies.xUserEmail
          return config
        config.headers["X-User-Token"] = $cookies.xUserToken
        config.headers["X-User-Email"] = $cookies.xUserEmail
        config
    ])

    $stateProvider.state
      name: "root"
      url: "/"
      controller: "RootController"
      controllerAs: "root"
      templateUrl: "modules/root/template.html"
      # abstract: true
    $stateProvider.state
      name: "login"
      url: "/login"
      template: "loginpage"
]
