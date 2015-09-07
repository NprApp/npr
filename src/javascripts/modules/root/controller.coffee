"use strict"

angular
  .module "npr.app"
  .controller "RootController", [
    "$scope",
    "$rootScope",
    "NavigationItems",
    "$cookies",
    "$state",
    ($scope, $rootScope, NavigationItems, $cookies, $state) ->
      $scope.navigationItems = NavigationItems.items
      if (!$cookies.get("xUserToken") || !$cookies.get("xUserEmail"))
        $state.transitionTo("login")
      $rootScope.$on("$stateChangeStart", (event, toState) ->
        if (!$cookies.get("xUserToken") || !$cookies.get("xUserEmail"))
          event.preventDefault()
          $state.transitionTo("login")
      )
  ]
