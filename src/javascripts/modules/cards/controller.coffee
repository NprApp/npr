"use strict"

angular.module("npr.app").controller "CardsController", ["Card",
  class Controller
    items: []
    constructor: (Card)->
      @Card = Card
      @items = Card.getList().$object
    createCard: (number) ->
      @items.push @Card.post(card: {number: number}).$object
]
