newsletter = angular.module('newsletter')
newsletter.factory('List', ['$resource',
  ($resource) ->
    List = $resource('/lists/:listId', {listId: '@id', format: 'json' },
    {
      'save':   {method:'PUT'},
      'create': {method:'POST'}
    }
    )
    return List
])
