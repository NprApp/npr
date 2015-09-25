export default class {
  static setStore(store) {
    this.store = store;
  }
  static buildAttributes() {
    this._attributes = {};
    _.each(_.keys(this.attributes), (key) => {
      const keySplitted = this.attributes[key].split(":");
      const type = keySplitted[0];
      let foreign_key = keySplitted[1];
      if (type !== "manyToOne") {
        this._attributes[key] = type;
        return;
      }
      if (!foreign_key) {
        foreign_key = key + "_id";
      }
      this._attributes[foreign_key] = "integer";
    });
  }
  constructor(data) {
    this._setProperties(data);
    this._ = _;
    this.store = this.constructor.store;
  }
  get attributes() {
    return this.constructor._attributes;
  }
  save() {
    let data = {};
    let promise;
    data[this._name] = {};

    this._.each(this._.keys(this.attributes), (key) => {
      data[this._name][key] = this[key];
    });

    if (this.id) {
      promise = this.
        store(this._name).
        update(this.id, data).
        then(this._afterSaveCallback.bind(this));
    } else {
      promise = this.
        store(this._name).
        create(data).
        then(this._afterSaveCallback.bind(this));
    }
    return promise;
  }
  reload() {
    this.store(this._name).get(this.id, true);
  }
  destroy() {
    this.$isDestroyed = true;
    this._willDestroy();
    this.store(this._name).destroy(this.id).then(() => {
      this._afterDestroy();
    });
  }
  reject() {
    this._restore();
  }
  isNew() {
    const idGreaterThanZero = this.id > 0;
    return !idGreaterThanZero;
  }
  _restore() {
    angular.extend(this, this._originalData);
  }
  _afterSaveCallback(record) {
    this._setProperties(record.data);
    this._afterSave();
    return record;
  }
  _setProperties(data) {
    angular.extend(this, data);
    this._originalData = data;
  }
  _calculateRelationForBaseModel(relation) {
    if(!this.constructor.attributes[relation]) {
      return;
    }
    const keySplitted = this.constructor.attributes[relation].split(":");
    const type = keySplitted[0];
    let foreign_key = keySplitted[1];
    if (type !== 'manyToOne') {
      return;
    }
    if (!foreign_key) {
      foreign_key = `${relation}_id`;
    }
    if (this[relation] && this[relation].id === this[foreign_key]) {
      return;
    }
    this[relation] = this.store(relation).get(this[foreign_key]);
    return foreign_key;
  }
  //HOOKS
  _willDestroy() {}
  _afterSave() {}
  _afterDestroy() {}
}
