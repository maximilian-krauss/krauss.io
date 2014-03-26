angular.module('krauss.io').factory 'socketFactory', [
  '$rootScope'
  '$location'
  ($rootScope, $location) ->
    socket = io.connect window.location.origin
    factory = {}

    factory.on = (event, callback) ->
      return

    factory.emit = (event, data) ->
      return

    factory
]
