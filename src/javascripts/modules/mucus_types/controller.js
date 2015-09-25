export default class {
  /*@ngInject*/
  constructor(store) {
    this.store = store;
    store('mucus_type').query().then((items) => {
      this.items = items;
    });
  }

  destroy(item) {
    this.store('mucus_type').destroyRecord(item);
  }
  switchFertility(item) {
    item.fertile = !item.fertile;
    item.save();
  }

  save() {
    const isNew = this.newType.isNew();
    this.newType.save().then((data) => {
      this.newFormVisible = false;
      if (isNew) {
        this.store('mucus_type').pushRecord(this.newType);
      }
      return data;
    });
  }

  create() {
    this.newType = this.store('mucus_type').createRecord({symbol: '12'}, true);
    this.newFormVisible = true;
  }

  cancel() {
    this.store('mucus_type').rejectRecord(this.newType);
    this.newFormVisible = false;
  }
}
