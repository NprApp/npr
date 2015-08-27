angular.module("npr.app")
  .service "model.card", ["BaseModel", (BaseModel) ->
    class Card extends BaseModel
      _name: "card"
      attributes:
        records: "oneToMany"
]
