angular.module("npr.app")
  .service "model.user", ["BaseModel", (BaseModel) ->
    class User extends BaseModel
      _name: "user"
      attributes:
        email: 'string'
]
