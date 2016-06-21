controllers = angular.module('controllers')
controllers.controller("ListsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/lists").search('keywords',keywords)
    List = $resource('/lists/:listId', { listId: "@id", format: 'json' })
    if $routeParams.keywords
      List.query(keywords: $routeParams.keywords, (results)-> $scope.lists = results)
    else
      $scope.lists = List.query()
    $scope.view = (listId)-> $location.path("/lists/#{listId}")
    $scope.newList = -> $location.path("/lists/new")
    $scope.edit      = (listId)-> $location.path("/lists/#{listId}/edit")
    $scope.newSubscriber     = (listId)-> $location.path("/lists/#{listId}/subscribers/new")
    $scope.deleteList = (list) ->
      if (confirm("Are you sure you want to delete this user?"))
        list.$delete ->
          $scope.lists = List.query()
          $location.path("/lists")
])
