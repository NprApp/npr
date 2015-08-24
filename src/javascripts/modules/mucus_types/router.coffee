angular.module("npr.app").config ["$stateProvider", ($stateProvider) ->
  $stateProvider.state
    name: "root.mucus_types"
    url: "mucus_types"
    controller: "MucusTypesController"
    controllerAs: "types"
    templateUrl: "modules/mucus_types/template.html"
]
