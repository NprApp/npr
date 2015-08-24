angular.module("npr.app").config ["$stateProvider", ($stateProvider) ->
  $stateProvider.state
    name: "root.cards"
    url: "cards"
    controller: "CardsController"
    controllerAs: "cards"
    templateUrl: "modules/cards/template.html"
    resolve:
      cards: ["Store", (Store) ->
        Store("card").query()
      ]
]
