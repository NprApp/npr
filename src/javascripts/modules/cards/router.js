import Controller from './controller.js';

angular.module('npr.app').config(function($stateProvider) {
  $stateProvider.state({
    name: 'root.cards',
    url: 'cards',
    controller: Controller,
    controllerAs: 'cards',
    templateUrl: 'modules/cards/template.html',
    resolve: {
      cards: function(store) {
        return store('card').query();
      }
    }
  });
});
