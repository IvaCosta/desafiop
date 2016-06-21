controllers = angular.module('controllers')
controllers.controller("SubscriberController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Subscriber = $resource('/lists/:listId/subscribers/:subscriberId', {listId: "@listId",  subscriberId: "@id", format: 'json' }
    {
        'get':    {method:'GET'},
        'save':   {method:'PUT'},
        'create': {method:'POST'},
        'query': { method: 'GET'},
        'update': { method: 'PUT', params: {listId: "@listId", id: '@id'} }
    }
    )
    $scope.subscribers = Subscriber.query(listId: $routeParams.listId, subscriberId: $routeParams.subscriberId)
    if $routeParams.subscriberId
      Subscriber.get({listId: $routeParams.listId, subscriberId: $routeParams.subscriberId},
        ( (subscriber)-> $scope.subscriber = subscriber ),
        ( (httpResponse)->
          $scope.subscriber = null
          flash.error   = "There is no subscriber with ID #{$routeParams.subscriberId}"
        )
      )
    else
      $scope.subscriber = {}
    $scope.listId = $routeParams.listId
    $scope.edit   =  -> $location.path("/lists/#{$scope.listId}/subscribers/#{$scope.subscriber.id}/edit")
    $scope.back   = -> $location.path("/lists/#{$scope.listId}")
    $scope.cancel = ->
      if $scope.subscriber.id
        $location.path("/lists/#{$scope.listId}/subscribers/#{$scope.subscriber.id}")
      else
        $location.path("/lists/#{$scope.listId}/subscribers")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.subscriber.id
        $scope.subscriber.$save(
          ( ()-> $location.path("/lists/#{$scope.listId}/subscribers/#{$scope.subscriber.id}") ),
          onError)
      else
        Subscriber.create($scope.subscriber,
          ( (newSubscriber)-> $location.path("/lists/#{NewSubscriber.listId}/subscribers/#{NewSubscriber.id}") ),
          onError
        )

    $scope.update = ->
      if $scope.subscriberForm.$valid
        Subscriber.update { listId: $scope.listId, subscriberId: $scope.subscriber.id }, { subscriber: $scope.subscriber }, (->
          $location.path("/lists/#{$scope.listId}")
        ), (error) ->
          console.log error


    $scope.delete = (subscriber) ->
      if (confirm("Are you sure you want to delete this user?"))
        subscriber.$delete ->
          $scope.subscribers = Subscriber.query()
          $location.path("/lists/#{$scope.listId}/subscribers/")


])
