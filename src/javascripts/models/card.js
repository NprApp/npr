import Base from '../providers/pg-data/model-base.js';

class Card extends Base {
  get _name() {
    return 'card';
  }
  get attributes() {
    return {
      records: 'oneToMany'
    };
  }
}

Base.bindToApp('pg-data', 'card', Card);
