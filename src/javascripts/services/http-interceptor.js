'use strict';

export default function($cookies) {
  'ngInject';
  return {
    request: function(config) {
      if (!$cookies.get('xUserToken') || !$cookies.get('xUserEmail')) {
        return config;
      }
      config.headers['X-User-Token'] = $cookies.get('xUserToken');
      config.headers['X-User-Email'] = $cookies.get('xUserEmail');
      return config;
    }
  };
}
