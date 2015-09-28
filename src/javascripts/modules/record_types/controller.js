export default class {
  /*@ngInject*/
  destroy(item) {
    this.store('record_type').destroyRecord(item);
  }
  save() {
    const isNew = this.newType.isNew();
    this.newType.save().then((data) => {
      this.newFormVisible = false;
      if (isNew) {
        this.store('record_type').pushRecord(this.newType);
      }
      return data;
    });
  }
  create() {
    this.newType = this.store('record_type').createRecord();
    this.newFormVisible = true;
  }

  cancel() {
    this.store('record_type').rejectRecord(this.newType);
    this.newFormVisible = false;
  }

  constructor(store) {
    this.store = store;
    store('record_type').query().then((items) => {
      this.items = items;
    });
  }
}
