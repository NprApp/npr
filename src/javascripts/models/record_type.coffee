angular.module("npr.app")
  .service "model.record_type", ["BaseModel", (BaseModel) ->
    class RecordType extends BaseModel

      attributes:
        name: "String"
        code: "String"

      _name: "record_type"
]
