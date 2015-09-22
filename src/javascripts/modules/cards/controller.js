export default function($scope, store, cards) {
  $scope.items = cards;
  $scope.create = function() {
    store('card').createRecord({}, true).save();
  };
}
