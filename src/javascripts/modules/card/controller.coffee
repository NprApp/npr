"use strict"

angular.module("npr.app").controller "CardController", ["Card", "Record", "$stateParams",
  class Controller
    constructor: (Card, Record, $stateParams)->
      @model = Card.get($stateParams.id).$object
      @records = Record.getList(card_id: $stateParams.id).$object
]
