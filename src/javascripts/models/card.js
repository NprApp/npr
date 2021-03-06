import PgDataBase from '../providers/pg-data/pg-data-base.js';
import Base from '../providers/pg-data/model-base.js';

PgDataBase.addModel('card', class extends Base {
    get _name() {
      return 'card';
    }
    static get attributes() {
      return {
        records: 'oneToMany'
      };
    }
  }
);
