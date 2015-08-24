angular.module("npr.app").directive "onEdit", ["$parse", ($parse)->
  restrict: "A"
  link: (scope, element, attrs) ->
    $(element).on "focusout", ->
      $parse(attrs.onEdit)(scope)

    $(element).on "keyup", (event) ->
      if event.keyCode is 13
        $parse(attrs.onEdit)(scope)
]
