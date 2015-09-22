import Controller from './controller.js';

angular.module('npr.app').config(function($stateProvider) {
  $stateProvider.state({
    name: 'root.mucus_types',
    url: 'mucus_types',
    controller: Controller,
    controllerAs: 'types',
    templateUrl: 'modules/mucus_types/template.html'
  });
});
