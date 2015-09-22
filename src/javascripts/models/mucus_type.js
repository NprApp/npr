import Base from '../providers/pg-data/model-base.js';

class MucusType extends Base {
  get _name() {
    return 'mucus_type';
  }
  get attributes() {
    return {
      symbol: 'String',
      peak_type: 'Bool',
      fertile: 'Bool'
    };
  }
}

Base.bindToApp('pg-data', 'mucus_type', MucusType);

angular.module('npr.app').filter('mucus_type_fertileText', function() {
  return function(_base, fertile) {
    if (fertile) {
      return 'Is';
    } else {
      return 'Isn\'t';
    }
  };
});
