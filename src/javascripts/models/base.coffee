angular.module("npr.app")
  .service "BaseModel", ["Store", "_", "$rootScope", (Store, _, $rootScope) ->
    class Base
      store: Store
      constructor: (data) ->
        @setProperties(data)
        _.each(_.keys(@attributes), (key) =>
          [type, foreign_key] = @attributes[key].split(":")
          return unless type == "manyToOne"
          foreign_key = "#{key}_id" unless foreign_key
          @attributes[foreign_key] = "integer"
          # console.log @[foreign_key]
        )

      save: ->
        data = {}
        data[@_name] = {}
        _.each(_.keys(@attributes), (key) =>
          data[@_name][key] = @[key]
        )
        if @id
          @store(@_name).update(@id, data).then (record) =>
            @setProperties(record)
        else
          @store(@_name).create(data).then (record) =>
            @setProperties(record.data)

      setProperties: (data) ->
        angular.extend(@, data)

      destroy: ->
        @_willDestroy()
        @store(@_name).destroy(@id)

      reject: ->

      isNew: ->
        !@id

      _willDestroy: ->

      _calculateRelationForBaseModel: (relation) ->
        [type, foreign_key] = @attributes[relation].split(":")
        return unless type == "manyToOne"
        foreign_key = "#{relation}_id" unless foreign_key
        return if @[relation] && @[relation].id == @[foreign_key]
        @[relation] = @store(relation).get(@[foreign_key])
        console.log @.id, @[relation]
        foreign_key
]
  .directive "bindRelation", ["$parse", "$compile", ($parse, $compile) ->
    restrict: 'E'
    link: (scope, element, attributes) ->
      { key, render } = attributes
      keys = key.split(".")
      # console.log keys
      _.each(keys, (value, index) ->
        binding = keys.slice(0, index).join(".")
        if foreign_key = $parse(binding)(scope)?._calculateRelationForBaseModel?(value)
          # console.log "#{binding}.#{foreign_key}"
          scope.$watch("#{binding}.#{foreign_key}", () ->
            # console.log 'watchit'
            $parse(binding)(scope)?._calculateRelationForBaseModel?(value)
          )
      )
      if render
        element.html("{{#{key}}}")
        $compile(element.contents())(scope)
]
