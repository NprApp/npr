"use strict"

angular
  .module "npr.app"
  .controller "LoginController", [
    "$scope",
    "$http",
    "$cookies",
    "$state",
    ($scope, $http, $cookies, $state) ->
      if ($cookies.get("xUserToken") && $cookies.get("xUserEmail"))
        $state.transitionTo("root.cards")
      $scope.user = {}
      $scope.signIn = ->
        $http
          .post "/sign_in",
            user: $scope.user
          .then (result) ->
            $cookies.put("xUserEmail", result.data.user_email)
            $cookies.put("xUserToken", result.data.user_token)
            $state.transitionTo("root.cards")
          .catch (reason) ->
            $scope.userError = reason.data.error

  ]
