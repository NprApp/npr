'use strict';

describe('Store $service', function() {
  beforeEach(module('npr.app'));
  var $service, record_store;

  beforeEach(inject(function(_Store_, _CacheService_) {
    $service = _Store_;
    // record_store = $service('record');
    cache = _CacheService_;
    // cache.
  }));
  it('service should have query method', function() {
    expect(record_store.query).toBeDefined();
  });
  it('service should have crud methods', function() {
    expect(record_store.create).toBeDefined();
    expect(record_store.update).toBeDefined();
    expect(record_store.destroy).toBeDefined();
  });
});
