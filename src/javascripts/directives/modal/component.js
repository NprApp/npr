function uiModal($compile, $templateCache, $timeout, $parse) {
  /*@ngInject*/
  return {
    restrict: 'E',
    link: function(scope, element, attrs) {
      const template = `
<div class="modal fade">
<div class="modal-dialog ${attrs.dialogClass}">
  <div class="modal-content">
    <div class="modal-body" ng-include="'${attrs.src}'"></div>
    <div class="modal-footer">
      <button type="button" class="btn btn-default" ng-click="${attrs.cancelAction}()">Cancel</button>
      <button type="button" class="btn btn-primary" ng-click="${attrs.okAction}()">Save</button>
    </div>
  </div>
</div>
</div>`;
      let modal = null;
      return scope.$watch(attrs.toggler, function(v) {
        if (v) {
          if (!modal) {
            modal = $compile(template)(scope);
            $('body').append(modal);
            $(modal[0]).modal();
            return $(modal[0]).on('hide.bs.modal', (function(_this) {
              return function() {
                $parse(attrs.cancelAction + '()')(scope);
                setTimeout(function() {
                  return scope.$apply();
                }, 10);
                return true;
              };
            })(this));
          } else {
            return $(modal[0]).modal('show');
          }
        } else {
          if (modal) {
            return $(modal[0]).modal('hide');
          }
        }
      }, true);
    }
  };
}

angular.module('angular-modal', []).directive('uiModal', uiModal);
