import Controller from './controller.js';

angular.module('npr.app').config(function($stateProvider) {
  $stateProvider.state({
    name: 'root.record_types',
    url: 'record_types',
    controller: Controller,
    controllerAs: 'types',
    templateUrl: 'modules/record_types/template.html'
  });
});
