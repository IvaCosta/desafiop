controllers = angular.module('controllers')
controllers.controller("ListController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    List = $resource('/lists/:listId', { listId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )
    if $routeParams.listId
      List.get({listId: $routeParams.listId},
        ( (list)-> $scope.list = list ),
        ( (httpResponse)->
          $scope.list = null
          flash.error   = "There is no list with ID #{$routeParams.listId}"
        )
      )
    else
      $scope.list = {}

    $scope.back   = -> $location.path("/lists")
    $scope.edit   = -> $location.path("/lists/#{$scope.list.id}/edit")
    $scope.cancel = ->
      if $scope.list.id
        $location.path("/lists/#{$scope.list.id}")
      else
        $location.path("/lists")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.list.id
        $scope.list.$save(
          ( ()-> $location.path("/lists/#{$scope.list.id}") ),
          onError)
      else
        List.create($scope.list,
          ( (newList)-> $location.path("/lists/#{newList.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.list.$delete()
      $scope.back()


])
