angular.module("npr.app")
  .service "model.record", ["BaseModel", (BaseModel) ->
    class User extends BaseModel
      _name: "user"
      attributes:
        email: 'string'
]
