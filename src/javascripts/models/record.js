import PgDataBase from '../providers/pg-data/pg-data-base.js';
import Base from '../providers/pg-data/model-base.js';

PgDataBase.addModel('record', class extends Base {
  get _name() {
    return 'record';
  }
  static get attributes() {
    return {
      record_type: 'manyToOne:type_id',
      mucus_type: 'manyToOne',
      card: 'manyToOne',
      bleeding_type: 'string',
      date: 'date',
      frequency: 'integer',
      peak_day: 'integer',
      details: 'string'
    };
  }

  _afterSave() {
    if(!this.card) {
      this._calculateRelationForBaseModel('card');
    }
    this.card.reload();
  }

  _afterDestroy() {
    this._afterSave();
  }
});
