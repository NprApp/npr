angular.module("npr.app").config ["$stateProvider", ($stateProvider) ->
  $stateProvider.state
    name: "root.record_types"
    url: "record_types"
    controller: "RecordTypesController"
    controllerAs: "types"
    templateUrl: "modules/record_types/template.html"
]
