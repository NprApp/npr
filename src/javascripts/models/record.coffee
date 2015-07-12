angular.module("npr.app")
  .factory "Record", ["Restangular", (Restangular) ->
    Restangular.all("records")
]
