angular.module('krauss.io').controller 'FooterCtrl', [
	'$scope',
	($scope) ->
		$scope.currentYear = new Date().getFullYear()
		return
]
