angular.module("angular-modal", []).directive("uiModal",[
  '$compile', '$templateCache', '$timeout', '$parse',
  ($compile, $templateCache, $timeout, $parse) ->
    restrict: 'E'
    link: (scope, element, attrs) ->
      template = '<div class="modal fade">'+
      '<div class="modal-dialog ' + attrs.dialogClass + '">'+
      '<div class="modal-content">'+
      '<div class="modal-body" ng-include="\'' + attrs.src + '\'">'+
      '</div>'+
      '<div class="modal-footer">'+
      '<button type="button" class="btn btn-default" ng-click="' + attrs.cancelAction + '()">Cancel</button>'+
      '<button type="button" class="btn btn-primary" ng-click="' + attrs.okAction + '()">Save</button>'+
      '</div>'+
      '</div>'+
      '</div>'+
      '</div>'
      modal = null
      scope.$watch attrs.toggler, (v)->
        if v
          unless modal
            modal = $compile(template)(scope)
            $('body').append modal
            $(modal[0]).modal()
            $(modal[0]).on 'hide.bs.modal', =>
              $parse("#{attrs.cancelAction}()")(scope)
              setTimeout ->
                scope.$apply()
              , 10
              true
          else
            $(modal[0]).modal('show')
        else
          $(modal[0]).modal('hide') if modal
      , true
])
