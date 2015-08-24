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
  "720kb.datepicker"])
angular.module("npr.app").config ["$stateProvider", "$urlRouterProvider", "RestangularProvider", ($stateProvider,  $urlRouterProvider, RestangularProvider) ->
  $urlRouterProvider.otherwise('/cards')
  $stateProvider.state
    name: "root"
    url: "/"
    controller: "RootController"
    controllerAs: "root"
    templateUrl: "modules/root/template.html"
    abstract: true
]
