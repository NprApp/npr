import BleedingTypes from '../../factories/bleeding-types.js';

export default class {
  /*@ngInject*/
  constructor($scope, $timeout, store, record_types, mucus_types, records, $stateParams) {
    $scope.model = store('card').get($stateParams.id);
    $scope.types = record_types;
    $scope.mucus_types = mucus_types;
    $scope.records = records;
    $scope.bleeding_types = BleedingTypes;
    $scope.view = {};
    $scope.cancel = function() {
      $scope.current.reject();
      $scope.view.newModalVisible = false;
    };
    $scope.save = function() {
      var isNew;
      isNew = $scope.current.isNew();
      return $scope.current.save().then(function(data) {
        if (isNew) {
          $scope.records.push($scope.current);
        }
        $scope.view.newModalVisible = false;
        // $timeout(function() {});
        return data;
      });
    };
    $scope.destroy = function(record) {
      record.destroy().then((data) => {
        const index = $scope.records.indexOf(record);
        if (index > -1) {
          $scope.records.splice(index, 1);
        }
        $timeout(function() {}, 800);
        return data;
      });
    };
    $scope.new = function() {
      var maxDate;
      maxDate = $scope.records.map(function(record) {
        return record.date;
      }).sort().reverse()[0];
      $scope.current = store('record').createRecord({
        date: moment(maxDate).add(1, 'day').format('YYYY-MM-DD'),
        card_id: $stateParams.id,
        frequency: 1
      });
      $scope.view.newModalVisible = true;
    };
    $scope.edit = function(record) {
      if (record.$isDestroyed) {
        return;
      }
      $scope.current = record;
      $scope.view.newModalVisible = true;
    };
    return $scope.$watch('current.mucus_type.symbol', function() {
      if( $scope.current && $scope.current.mucus_type && $scope.current.mucus_type.symbol === '0') {
        $scope.current.frequency = 0;
      }
    });
  }
}
