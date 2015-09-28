import PgDataBase from '../providers/pg-data/pg-data-base.js';
import Base from '../providers/pg-data/model-base.js';

PgDataBase.addModel('user',
  class extends Base {
    get _name() {
      return 'user';
    }
    static get attributes() {
      return {
        email: 'String',
        password: 'String',
        password_confirmation: 'String',
        is_admin: 'Boolean'
      };
    }
  }
);
