class Store
  constructor: (name, pluralize, baseUrl, $http, CacheService, _, $rootScope, $timeout) ->
    @_name = name
    @_resource = pluralize || (name + "s")
    @_baseUrl = baseUrl || "#{@_resource}/:id"
    @_model = angular.injector(["npr.app"]).get("model.#{name}")
    @_cache = CacheService
    @_http = $http
    @_rootScope = $rootScope
    @_timeout = $timeout
    @_ = _

  _buildUrl: (params) ->
    params_parsed = angular.extend({}, params)
    if params_parsed.id
      @_baseUrl.replace(":id", params_parsed.id)
    else
      @_baseUrl.replace("/:id", "")

  create: (data) ->
    promise = @_http.post(@_buildUrl(), data)
    promise.then (record) =>
      new @_model(record)

  update: (id, data) ->
    @_http.put(@_buildUrl(id: id), data)

  destroy: (id) ->
    @_http.delete(@_buildUrl(id: id))

  query: (params, reload) ->
    if @_cache.get("#{@_name}.data") && !params && !reload
      promise = @_cache.get("#{@_name}.data")
      promise.$object = @_cache.get("#{@_name}.data.$object")
    else
      promise = @_http.get(@_buildUrl(), params: params).then (resource) =>
        @_.each resource.data, (record) =>
          model = new @_model(record)
          promise.$object.push model
          @_cache.put("#{@_name}.map.#{record.id}", model)
        unless params
          @_cache.put("#{@_name}.data", promise)
          @_cache.put("#{@_name}.data.$object", promise.$object)
        promise.$object
      promise.$object = []
    promise

  createRecord: (data, push) ->
    record = new @_model(data)
    @pushRecord(record) if push
    record

  pushRecord: (record) ->
    @_cache.get("#{@_name}.data").then (data) ->
      data.push record

  destroyRecord: (record) ->
    if record.isNew()
      @removeRecord(record)
    else
      record.destroy().then =>
        @removeRecord(record)

  removeRecord: (record) ->
    @_cache.get("#{@_name}.data").then (data) ->
      index = data.indexOf(record)
      data.splice index, 1 if index > -1
    data = @_cache.get("#{@_name}.data.$object")
    index = data.indexOf(record)
    data.splice index, 1 if index > -1

  rejectRecord: (record) ->
    record.reject()
    unless record.id
      @destroyRecord(record)

  get: (id, force) ->
    return null unless id
    record_object = @_cache.get("#{@_name}.map.#{id}")
    return record_object if record_object && !force
    promise = @_http.get(@_buildUrl(id: id))
    record_object = new @_model(promise.$object) unless force
    promise.then (record) ->
      record_object._setProperties(record.data)
      record
    @_cache.put("#{@_name}.map.#{id}", record_object)
    record_object

angular.module("angular-data", ["angular-cache"])
  .factory "Store", ["$http", "CacheService", "_", "$rootScope", "$timeout", ($http, CacheService, _, $rootScope, $timeout) ->
    (name, pluralize) ->
      console.log 'store instant'
      new Store(name, pluralize, null, $http, CacheService, _, $rootScope, $timeout)
]
