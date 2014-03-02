(function() {
  angular.module('krauss.io.directives').directive('krLoader', function() {
    return {
      restrict: 'E',
      replace: true,
      transclude: true,
      template: '<div class="directive loader"><i class="fa fa-refresh fa-spin"></i> <span ng-transclude></span></div>'
    };
  });

}).call(this);
