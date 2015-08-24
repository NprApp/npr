"use strict"

angular.module("npr.app").controller "CardsController", ["$scope", "Store", "cards",
  ($scope, Store, cards) ->
    $scope.items = cards
    console.log cards

    $scope.create = ->
      Store("card").createRecord({}, true).save()
]
