"use strict"

angular.module("npr.app").controller "CardsController", ["$scope", "Store", "cards",
  ($scope, Store, cards) ->
    $scope.items = cards

    $scope.create = ->
      Store("card").createRecord({}, true).save()

    $scope.debug = (card) ->
      console.log card
]
