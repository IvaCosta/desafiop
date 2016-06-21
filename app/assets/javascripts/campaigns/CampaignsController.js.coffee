controllers = angular.module('controllers')
controllers.controller("CampaignsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/campaigns").search('keywords',keywords)
    Campaign = $resource('/campaigns/:campaignId', { campaignId: "@id", format: 'json' })
    if $routeParams.keywords
      Campaign.query(keywords: $routeParams.keywords, (results)-> $scope.campaigns = results)
    else
      $scope.campaigns = Campaign.query()
    $scope.view = (campaignId)-> $location.path("/campaigns/#{campaignId}")
    $scope.newCampaign = -> $location.path("/campaigns/new")
    $scope.edit      = (campaignId)-> $location.path("/campaigns/#{campaignId}/edit")
    $scope.deleteCampaign = (campaign) ->
      if (confirm("Are you sure you want to delete this user?"))
        campaign.$delete ->
          $scope.campaigns = Campaign.query()
          $location.path("/campaigns/")
])
