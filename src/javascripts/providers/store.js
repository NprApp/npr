import PgDataBase from './pg-data/pg-data-base.js';
import Base from '../providers/pg-data/model-base.js';
import HttpInterceptor from '../services/http-interceptor.js';

angular.module('pg-data', ['underscore', 'ngResource', 'angular-cache', 'ngCookies']);

angular.module('pg-data').config(function($httpProvider) {
  $httpProvider.interceptors.push(HttpInterceptor);
});

angular.module('pg-data').provider('store', class storeClass {
  /*@ngInject*/
  constructor() {
    console.log('store', this);
    PgDataBase.setStore(this.getFn.bind(this));
    this._map = {};
  }

  $get($http, $timeout) {
    /*@ngInject*/
    this.$http = $http;
    this.$timeout = $timeout;
    return this.getFn.bind(this);
  }

  getFn(name, pluralize, baseUrl) {
    let storeByName = this._map[name];
    if(!storeByName) {
      storeByName = this._map[name] = new PgDataBase(name, pluralize, baseUrl, this.$http, this.$timeout);
    }
    return storeByName;
  }
});

angular.module('pg-data').provider('baseModel', class {
  $get() {
    return Base;
  }
});

angular.module('pg-data').directive('bindRelation', function($parse, $compile, _, $timeout) {
  return {
    restrict: 'E',
    link: function(scope, element, attributes) {
      const { key, render } = attributes;
      const keys = key.split('.');
      _.each(keys, function(value, index) {
        let foreign_key;
        const binding = keys.slice(0, index).join('.');
        let bindModel = $parse(binding)(scope);
        if(bindModel && bindModel._calculateRelationForBaseModel) {
          // $timeout(() => {
          foreign_key = bindModel._calculateRelationForBaseModel(value);
          // });
        }
        if(foreign_key) {
          scope.$watch(`${binding}.${foreign_key}`, function() {
            // $timeout(() => {
              bindModel._calculateRelationForBaseModel(value);
            // });
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
