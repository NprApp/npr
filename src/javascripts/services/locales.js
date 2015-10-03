import locales from '../factories/locales.js';

function localesService() {
  return locales;
}

class currentLocale {
  constructor() {
    this.locale = '';
  }

  setLocale(code) {
    this.locale = code;
    moment.locale(code);
  }

  getLocale() {
    return this.locale;
  }

  $get() {
    return this;
  }
}

function i18n(locales, currentLocale) {
  /*@ngInject*/
  return function(code) {
    let text = code;
    try {
      text = locales[currentLocale.getLocale()][code] || code;
    } catch(e) {
      text = code;
    }
    return text;
  };
}

angular.module('i18n', []).factory('locales', localesService);
angular.module('i18n').provider('currentLocale', currentLocale);
angular.module('i18n').filter('i18n', i18n);
