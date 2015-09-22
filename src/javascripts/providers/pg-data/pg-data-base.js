export default class {
  constructor(name, pluralize, baseUrl, $http, _, $timeout) {
    this._resource = pluralize || `${name}s`;
    this._baseUrl = baseUrl || `${this._resource}/:id`;
    this._model = angular.injector(['pg-data']).get('model.' + name);
    this._http = $http;
    this._promise = null;
    this._map = {};
    this._ = _;
    this._timeout = $timeout;
  }
  _buildUrl(params) {
    const params_parsed = angular.extend({}, params);
    if (params_parsed.id) {
      return this._baseUrl.replace(":id", params_parsed.id);
    } else {
      return this._baseUrl.replace("/:id", "");
    }
  }
  create(data) {
    let promise = this._http.post(this._buildUrl(), data);
    return promise.then((record) => {
      return this._model(record);
    });
  }
  update(id, data) {
    return this._http.put(this._buildUrl({id}), data);
  }
  destroy(id) {
    return this._http.delete(this._buildUrl(id));
  }
  query(params, reload) {
    let promise;
    if (this._promise && !params && !reload) {
      promise = this._promise;
    } else {
      this._promise = this._http.get(this._buildUrl(), {
        params: params
      });
      this._promise.then((resource) => {
        this._.each(resource.data, (record) => {
          let model = new this._model(record);
          this._promise.$object.push(model);
          this._map[record.id] = model;
        });

        return this._promise.$object;
      });
      this._promise.$object = [];
    }
    return this._promise;
  }
  createRecord(data, push) {
    let record = new this._model(data);
    if(push) {
      this.pushRecord(record);
    }
    return record;
  }
  pushRecord(record) {
    return this._promise.then((data) => {
      this._timeout(() => {
        this._promise.$object.push(record);
      });
      return data;
    });
  }
  destroyRecord(record) {
    if (record.isNew()) {
      return this.removeRecord(record);
    } else {
      return record.destroy().then(() => {
        return this.removeRecord(record);
      });
    }
  }
  removeRecord(record) {
    this._promise.then(() => {
      const index = this._promise.$object.indexOf(record);
      if (index > -1) {
        return this._promise.$object.splice(index, 1);
      }
    });

    const index = this._promise.$object.indexOf(record);
    if (index > -1) {
      return this._promise.$object.splice(index, 1);
    }
  }
  rejectRecord(record) {
    record.reject();
    if (!record.id) {
      return this.destroyRecord(record);
    }
  }
  get(id, force) {
    var promise, record_object;
    if (!id) {
      return null;
    }
    record_object = this._map[id];
    if (record_object && !force) {
      return record_object;
    }
    promise = this._http.get(this._buildUrl({
      id: id
    }));
    if (!force) {
      record_object = new this._model(promise.$object);
    }
    promise.then(function(record) {
      record_object._setProperties(record.data);
      return record;
    });
    this._map[id] = record_object;
    return record_object;
  }
}
