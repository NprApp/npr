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
    $httpProvider.interceptors.push(["$cookies", ($cookies) ->
      request: (config) ->
        if !$cookies.get("xUserToken") || !$cookies.get("xUserEmail")
          return config
        config.headers["X-User-Token"] = $cookies.get("xUserToken")
        config.headers["X-User-Email"] = $cookies.get("xUserEmail")
        config
    ])

    $stateProvider.state
      name: "root"
      url: "/"
      controller: "RootController"
      controllerAs: "root"
      templateUrl: "modules/root/template.html"
    $stateProvider.state
      name: "login"
      url: "/login"
      controller: "LoginController"
      templateUrl: "modules/login/template.html"

]
