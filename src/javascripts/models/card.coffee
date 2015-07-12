angular.module("npr.app")
  .factory "Card", ["Restangular", (Restangular) ->
    Restangular.all("cards")
]
