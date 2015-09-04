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
      if (!$cookies.xUserToken || !$cookies.xUserEmail)
        $state.transitionTo("login")
      $rootScope.$on("$stateChangeStart", (event, toState) ->
        if (!$cookies.xUserToken || !$cookies.xUserEmail)
          event.preventDefault()
          $state.transitionTo("login")
      )
  ]
