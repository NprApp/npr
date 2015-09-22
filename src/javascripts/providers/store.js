import PgDataBase from './pg-data/pg-data-base.js';
import HttpInterceptor from '../services/http-interceptor.js';

angular.module('pg-data', ['underscore', 'ngResource', 'angular-cache', 'ngCookies']);

angular.module('pg-data').config(function($httpProvider) {
  $httpProvider.interceptors.push(HttpInterceptor);
});

angular.module('pg-data').provider('store', class storeClass {
  /*@ngInject*/
  constructor() {
    this._map = {};
  }

  setApp(appName) {
    this.appName = appName;
  }

  $get($http, _, $timeout) {
    /*ngInject*/
    return (name, pluralize, baseUrl) => {
      let storeByName = this._map[name];
      if(!storeByName) {
        storeByName = this._map[name] = new PgDataBase(name, pluralize, baseUrl, $http, _, $timeout);
      }
      return storeByName;
    };
  }
});

angular.module('pg-data').directive('bindRelation', function($parse, $compile, _) {
  return {
    restrict: 'E',
    link: function(scope, element, attributes) {
      const key = attributes.key;
      const render = attributes.render;
      const keys = key.split('.');
      _.each(keys, function(value, index) {
        let foreign_key;
        const binding = keys.slice(0, index).join('.');
        let bindModel = $parse(binding)(scope);
        if(bindModel && bindModel._calculateRelationForBaseModel) {
          foreign_key = bindModel._calculateRelationForBaseModel(value);
        }
        if(foreign_key) {
          scope.$watch(`${binding}.${foreign_key}`, function() {
            bindModel._calculateRelationForBaseModel(value);
          });
        }
      });
      if (render) {
        element.html('{{' + key + '}}');
        return $compile(element.contents())(scope);
      }
    }
  };
});
