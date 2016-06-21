controllers = angular.module('controllers')
controllers.controller("SubscribersController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (listId, keywords)->  $location.path("/lists/#{listId}").search('keywords',keywords)
    Subscriber = $resource('/lists/:listId/subscribers/:subscriberId', { listId: "@listId", subscriberId: "@id", format: 'json' })
    if $routeParams.keywords
      Subscriber.query(listId: $routeParams.listId, keywords: $routeParams.keywords, (results)-> $scope.subscribers = results)
    else
      $scope.subscribers = Subscriber.query(listId: $routeParams.listId)
    $scope.view = (listId, subscriberId) -> $location.path("/lists/#{listId}/subscribers/#{subscriberId}")
    $scope.newSubscriber = (listId)-> $location.path("/lists/#{listId}/subscribers/new")
    $scope.edit   = (listId, subscriberId) -> $location.path("/lists/#{listId}/subscribers/#{subscriberId}/edit")
    $scope.save = ->
      obj = new Subscriber(name: $scope.subscriber.name, email: $scope.subscriber.email, listId: $routeParams.listId)
      obj.$save ((response) ->
        $scope.subscribers.unshift(response)
        $scope.subscriber.name = $scope.subscriber.email = ''
      ), (response) ->
        $scope.errors = response.data.errors

    $scope.delete = (listId, index) ->
      Subscriber.remove { listId: listId, subscriberId: $scope.subscribers[index].id }, ->
        $scope.subscribers.splice(index, 1)


])
