"use strict"

angular
  .module "npr.app"
  .controller "ApplicationController", [
    class Control
      appTitle: "NPR Track Your Fertitlity"

      constructor: ->
        @appTitle = "Track It"
  ]
