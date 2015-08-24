"use strict"

angular.module("npr.app").controller "RecordTypesController", ["$scope", "Store",
  ($scope, Store) ->
    $scope.items = Store("record_type").query().$object
    $scope.view = {}

    $scope.destroy = (item) ->
      Store("record_type").destroyRecord item

    $scope.save = (item) ->
      isNew = item.isNew()
      item.save().then (data) ->
        $scope.view.newFormVisible = false
        if isNew
          Store("record_type").pushRecord(item)
        data

    $scope.create = ->
      $scope.new_type = Store("record_type").createRecord()
      $scope.view.newFormVisible = true

    $scope.cancel = (item) ->
      Store("record_type").rejectRecord(item)
      $scope.view.newFormVisible = false
]
