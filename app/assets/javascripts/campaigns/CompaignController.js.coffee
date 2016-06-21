controllers = angular.module('controllers')
controllers.controller("CampaignController", [ '$scope', '$routeParams', '$resource', '$location', 'flash', 'List',
  ($scope,$routeParams,$resource,$location, flash, List)->
    Campaign = $resource('/campaigns/:campaignId', { campaignId: "@id", format: 'json' },
      {
        'get':   {method:'GET' , params: {campaignId: '@id'} },
        'save':   {method:'PUT'},
        'create': {method:'POST', params: {out: "@out"}}
      }
    )
    if $routeParams.campaignId
      Campaign.get({campaignId: $routeParams.campaignId},
        ( (campaign)-> $scope.campaign = campaign),
        ( (httpResponse)->
          $scope.campaign = null
          flash.error   = "There is no Campaign with ID #{$routeParams.campaignId}"
        )
      )
    else
      $scope.campaign = {}
    $scope.lists = List.query()
    $scope.output = ""
    $scope.out = []
    $scope.back   = -> $location.path("/campaigns")
    $scope.edit   = -> $location.path("/campaigns/#{$scope.campaign.id}/edit")
    $scope.cancel = ->
      if $scope.campaign.id
        $location.path("/campaigns/#{$scope.campaign.id}")
      else
        $location.path("/campaigns")

    $scope.save =  ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.campaign.id
        $scope.campaign.$save({list_ids: JSON.stringify($scope.output)},
          ( ()-> $location.path("/campaigns/#{$scope.campaign.id}") ),
          onError)
      else
        Campaign.create({list_ids: JSON.stringify($scope.output)},$scope.campaign,
          ( (newCampaign)-> $location.path("/campaigns/#{newCampaign.id}") ),
          onError
        )

    $scope.send =  ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      Campaign.create({list_ids: JSON.stringify($scope.output), send: true},$scope.campaign,
        ( (newCampaign)-> $location.path("/campaigns") ),
        onError
      )


    $scope.delete = ->
      $scope.campaign.$delete()
      $scope.back()
])
