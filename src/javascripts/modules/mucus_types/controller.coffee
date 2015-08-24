"use strict"

angular.module("npr.app").controller "MucusTypesController", ["$scope", "Store",
  ($scope, Store) ->
    promise = Store("mucus_type").query()
    $scope.items = promise.$object
    $scope.view = {}

    $scope.destroy = (item) ->
      Store("mucus_type").destroyRecord item

    $scope.switchFertility = (item) ->
      item.fertile = !item.fertile
      item.save()

    $scope.save = (item) ->
      isNew = item.isNew()
      item.save().then (data) ->
        $scope.view.newFormVisible = false
        if isNew
          Store("mucus_type").pushRecord(item)
        data

    $scope.create = ->
      $scope.new_type = Store("mucus_type").createRecord()
      $scope.view.newFormVisible = true

    $scope.cancel = (item) ->
      Store("mucus_type").rejectRecord(item)
      $scope.view.newFormVisible = false
]
