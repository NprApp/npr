"use strict"

angular.module("npr.app").controller "CardController", [
  "$scope",
  "Store",
  "record_types",
  "mucus_types",
  "records",
  "$stateParams",
  "BleedingTypes"
  ($scope, Store, record_types, mucus_types, records, $stateParams, BleedingTypes) ->
    $scope.model = Store("card").get($stateParams.id)
    $scope.types = record_types
    $scope.mucus_types = mucus_types
    $scope.bleeding_types = BleedingTypes
    $scope.records = records
    $scope.view = {}

    $scope.cancel = ->
      $scope.current.reject()
      $scope.view.newModalVisible = false

    $scope.save = ->
      isNew = $scope.current.isNew()
      $scope.current.save().then (data) ->
        if isNew
          $scope.records.push $scope.current
        $scope.view.newModalVisible = false
        $scope.$apply()
        data

    $scope.destroy = (record) ->
      record.destroy().then =>
        index = $scope.records.indexOf record
        if index > -1
          $scope.records.splice index, 1
        $scope.$apply()

    $scope.new = ->
      maxDate = $scope.records.map( (record) -> record.date ).sort().reverse()[0]
      $scope.current = Store("record").createRecord(
        date: moment(maxDate).add(1, 'day').format("YYYY-MM-DD")
        card_id: $stateParams.id
        frequency: 1
      )
      $scope.view.newModalVisible = true

    $scope.edit = (record) ->
      $scope.current = record
      $scope.view.newModalVisible = true

    $scope.$watch "current.mucus_type.symbol", ->
      if $scope.current?.mucus_type?.symbol == "0"
        $scope.current.frequency = 0


]
