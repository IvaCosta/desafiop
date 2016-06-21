'use strict'
newsletter = angular.module('newsletter')
newsletter.factory('Subscriber', ['$resource',
  ($resource) ->
    return $resource('/lists/:id', {id: '@id'})
])