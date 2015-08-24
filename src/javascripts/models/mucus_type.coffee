angular.module("npr.app")
  .service "model.mucus_type", ["BaseModel", "$rootScope", (BaseModel, $rootScope) ->
    class MucusType extends BaseModel
      _name: "mucus_type"
      attributes:
        symbol: "String"
        peak_type: "Bool"
        fertile: "Bool"
]
  .filter "mucus_type_fertileText", ->
    (_base, fertile) ->
      if fertile then "Is" else "Isn't"
