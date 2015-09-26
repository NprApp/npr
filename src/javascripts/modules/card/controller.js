import BleedingTypes from '../../factories/bleeding-types.js';

export default class {
  /*@ngInject*/
  constructor($scope, store, record_types, mucus_types, records, $stateParams) {
    this.card_id = $stateParams.id;
    this.store = store;
    this.model = this.store('card').get(this.card_id);
    this.duration = moment(this.model.max_date).diff(this.model.min_date, 'days');
    this.types = record_types;
    this.mucus_types = mucus_types;
    this.records = records;
    this._prepareDays();
    this.bleeding_types = BleedingTypes;
    $scope.$watch('card.current.mucus_type.symbol', this._mucusTypeWatcher.bind(this));
  }

  _prepareDays() {
    this.days = [];
    this.map = {};
    const dates = this.records.map(record => {
      this.map[record.date] = record;
      return record.date
    }).sort();
    const minDate = dates[0];
    const maxDate = dates[dates.length - 1];
    let size = moment(maxDate).diff(minDate, 'days') + 1;
    let date = moment(minDate);
    while(size > 0) {
      let formattedDate = date.format("YYYY-MM-DD");
      this.days.push(this.map[formattedDate] || {date: formattedDate, blank: true});
      date.add(1, 'day');
      size--;
    }
  }

  _mucusTypeWatcher() {
    if(this.current && this.current.mucus_type && this.current.mucus_type.symbol === '0') {
      this.current.frequency = 0;
    }
  }

  cancel() {
    if(this.current && this.current.reject) {
      this.current.reject();
    }
    this.newModalVisible = false;
  }

  save() {
    var isNew;
    isNew = this.current.isNew();
    return this.current.save().then(() => {
      if (isNew) {
        this.records.push(this.current);
      }
      this._prepareDays();
      this.newModalVisible = false;
    });
  }

  destroy(record) {
    record.destroy().then(() => {
      const index = this.records.indexOf(record);
      if (index > -1) {
        this.records.splice(index, 1);
        this._prepareDays();
      }
    });
  }

  new(date) {
    const maxDate = date || this.records.map(record => record.date).sort().reverse()[0];
    this.current = this.store('record').createRecord({
      date: moment(maxDate).add(1, 'day').format('YYYY-MM-DD'),
      'card_id': this.card_id,
      frequency: 1
    });
    this.newModalVisible = true;
  }

  edit(record) {
    if (record.$isDestroyed) {
      return;
    }
    if(record.blank) {
      this.new(record.date);
    } else {
      this.current = record;
      this.newModalVisible = true;
    }
  }
}
