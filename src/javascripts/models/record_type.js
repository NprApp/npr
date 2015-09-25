import PgDataBase from '../providers/pg-data/pg-data-base.js';
import Base from '../providers/pg-data/model-base.js';

PgDataBase.addModel('record_type',
  class extends Base {
    get _name() {
      return 'record_type';
    }
    static get attributes() {
      return {
        name: 'String',
        code: 'String'
      };
    }
  }
);
