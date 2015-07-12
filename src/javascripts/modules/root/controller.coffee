"use strict"

angular
  .module "npr.app"
  .controller "RootController", ["NavigationItems", (NavigationItems) ->
    @navigationItems = NavigationItems.items
    @
  ]
