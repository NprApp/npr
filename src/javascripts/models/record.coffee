angular.module("npr.app")
  .service "model.record", ["BaseModel", (BaseModel) ->
    class Record extends BaseModel
      _name: "record"
      attributes:
        record_type: "manyToOne:type_id"
        mucus_type: "manyToOne"
        card: "manyToOne"
        bleeding_type: "string"
        date: "date"
        frequency: "integer"
        peak_day: "integer"
        details: "string"
      _afterSave: ->
        @_calculateRelationForBaseModel('card') unless @card
        @card.reload()

      _afterDestroy: ->
        @_afterSave()
]
