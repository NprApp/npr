export default function($scope, $http, $cookies, $state) {
  'ngInject';
  if ($cookies.get('xUserToken') && $cookies.get('xUserEmail')) {
    $state.transitionTo('root.cards');
  }
  $scope.user = {};
  $scope.signIn = function() {
    $http.post('/sign_in', {
      user: $scope.user
    }).then(function(result) {
      $cookies.put('xUserEmail', result.data.user_email);
      $cookies.put('xUserToken', result.data.user_token);
      $state.transitionTo('root.cards');
    })['catch'](function(reason) {
      $scope.userError = reason.data.error;
    });
  };
}
