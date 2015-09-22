import Controller from './controller.js';

angular.module('npr.app').config(function($stateProvider) {
  $stateProvider.state({
    name: 'root.cards.card',
    url: '/:id',
    controller: Controller,
    controllerAs: 'card',
    templateUrl: 'modules/card/template.html',
    resolve: {
      'record_types': function(store) {
        return store('record_type').query();
      },
      'mucus_types': function(store) {
        return store('mucus_type').query();
      },
      records: function(store, record_types, mucus_types, $stateParams) {
        return store('record').query({
          card_id: $stateParams.id
        });
      }
    }
  });
});
