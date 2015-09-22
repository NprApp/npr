class Base
  constructor: (data) ->
    @_setProperties(data)
    @store = angular.injector(["npr.app"]).get("Store")
    @_  = angular.injector(["npr.app"]).get("_")
    # @_rootScope = angular.injector(["npr.app"]).get("$rootScope")
    # @_timeout = angular.injector(["npr.app"]).get("$timeout")
    @_.each(_.keys(@attributes), (key) =>
      [type, foreign_key] = @attributes[key].split(":")
      return unless type == "manyToOne"
      foreign_key = "#{key}_id" unless foreign_key
      @attributes[foreign_key] = "integer"
    )

  save: ->
    data = {}
    data[@_name] = {}
    @_.each(_.keys(@attributes), (key) =>
      data[@_name][key] = @[key]
    )
    if @id
      @store(@_name).update(@id, data).then (record) =>
        @_setProperties(record)
        @_afterSave()
        record
    else
      @store(@_name).create(data).then (record) =>
        @_setProperties(record.data)
        @_afterSave()
        record

  reload: ->
    @store(@_name).get(@id, true)
    return

  _setProperties: (data) ->
    angular.extend(@, data)
    @_originalData = data

  _restore: ->
    angular.extend(@, @_originalData)

  destroy: ->
    @$isDestroyed = true
    @_willDestroy()
    @store(@_name).destroy(@id).then =>
      @_afterDestroy()

  reject: ->
    @_restore()

  isNew: ->
    !@id

  _willDestroy: ->

  _afterSave: ->
    return

  _afterDestriy: ->
    return

  _calculateRelationForBaseModel: (relation) ->
    return unless @attributes[relation]
    [type, foreign_key] = @attributes[relation].split(":")
    return unless type == "manyToOne"
    foreign_key = "#{relation}_id" unless foreign_key
    return if @[relation] && @[relation].id == @[foreign_key]
    @[relation] = @store(relation).get(@[foreign_key])
    foreign_key

angular.module("npr.app")
  .factory "BaseModel", ["Store", "_", "$rootScope", "$timeout", (Store, _, $rootScope, $timeout) ->
    console.log 'adad'
    Base
]
  .directive "bindRelation", ["$parse", "$compile", ($parse, $compile) ->
    restrict: 'E'
    link: (scope, element, attributes) ->
      { key, render } = attributes
      keys = key.split(".")
      _.each(keys, (value, index) ->
        binding = keys.slice(0, index).join(".")
        if foreign_key = $parse(binding)(scope)?._calculateRelationForBaseModel?(value)
          scope.$watch("#{binding}.#{foreign_key}", () ->
            $parse(binding)(scope)?._calculateRelationForBaseModel?(value)
          )
      )
      if render
        element.html("{{#{key}}}")
        $compile(element.contents())(scope)
]
