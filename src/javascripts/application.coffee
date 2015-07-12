angular.module("npr.app",["ui.router", "ngResource", "ngAnimate", "restangular"])
angular.module("npr.app").config ["$stateProvider", "$urlRouterProvider", ($stateProvider,  $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/')
  $stateProvider.state
    name: "root"
    url: "/"
    controller: "RootController"
    controllerAs: "root"
    templateUrl: "modules/root/template.html"
  $stateProvider.state
    name: "root.cards"
    url: "cards"
    controller: "CardsController"
    controllerAs: "cards"
    templateUrl: "modules/cards/template.html"
  $stateProvider.state
    name: "root.cards.card"
    url: "/:id"
    controller: "CardController"
    controllerAs: "card"
    templateUrl: "modules/card/template.html"
]
