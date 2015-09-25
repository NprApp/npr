import PgDataBase from '../providers/pg-data/pg-data-base.js';
import Base from '../providers/pg-data/model-base.js';

PgDataBase.addModel('mucus_type',
  class extends Base {
    get _name() {
      return 'mucus_type';
    }
    static get attributes() {
      return {
        symbol: 'String',
        peak_type: 'Bool',
        fertile: 'Bool'
      };
    }
  }
);

angular.module('npr.app').filter('mucus_type_fertileText', function() {
  return function(_base, fertile) {
    if (fertile) {
      return 'Is';
    } else {
      return 'Isn\'t';
    }
  };
});
