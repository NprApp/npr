export default class {
  constructor(data) {
    this._setProperties(data);
    this.store = angular.injector(['pg-data']).get('store');
    this._ = angular.injector(['pg-data']).get('_');

    this._.each(this._.keys(this.attributes), (key) => {
      const keySplitted = this.attributes[key].split(":");
      const type = keySplitted[0];
      let foreign_key = keySplitted[1];
      if (type !== "manyToOne") {
        return;
      }
      if (!foreign_key) {
        foreign_key = key + "_id";
      }
      this.attributes[foreign_key] = "integer";
    });
  }

  static bindToApp(name, modelName, bindClass) {
    angular.module(name).factory(`model.${modelName}`, function() {
      return bindClass;
    });
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
    const keySplitted = this.attributes[relation].split(":");
    const type = keySplitted[0];
    let foreign_key = keySplitted[1];
    if (type !== "manyToOne") {
      return;
    }
    if (!foreign_key) {
      foreign_key = relation + "_id";
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
