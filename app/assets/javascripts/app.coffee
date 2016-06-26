newsletter = angular.module('newsletter',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'Devise',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])
newsletter.config([ '$routeProvider', 'flashProvider',
  ($routeProvider, flashProvider)->
    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "home/index.html"
        controller: 'HomeController'
      ).when('/lists',
        templateUrl: "lists/index.html"
        controller: 'ListsController'
      ).when('/lists/new',
        templateUrl: "lists/form.html"
        controller: 'ListController'
      ).when('/lists/:listId',
        templateUrl: "lists/show.html"
        controller: 'ListController'
      ).when('/lists/:listId/edit',
        templateUrl: "lists/form.html"
        controller: 'ListController'
      ).when('/lists/:listId/subscribers/new',
        templateUrl: "subscribers/form.html"
        controller: 'SubscribersController'
      ).when('/lists/:listId/subscribers/:subscriberId',
        templateUrl: "subscribers/show.html"
        controller: 'SubscriberController'
      ).when('/lists/:listId/subscribers/:subscriberId/edit',
        templateUrl: "subscribers/edit.html"
        controller: 'SubscriberController'
      ).when('/campaigns',
        templateUrl: "campaigns/index.html"
        controller: 'CampaignsController'
      ).when('/campaigns/new',
        templateUrl: "campaigns/form.html"
        controller: 'CampaignController'
      ).when('/campaigns/:campaignId',
        templateUrl: "campaigns/show.html"
        controller: 'CampaignController'
      ).when('/campaigns/:campaignId/edit',
        templateUrl: "campaigns/form.html"
        controller: 'CampaignController'
      ).when('/login',
        templateUrl: 'auth/_login.html'
        controller: 'AuthController',
        onEnter: [ '$scope', '$routeParams', '$location', '$resource','Auth',
         ($scope,$routeParams,$location,$resource, Auth)->
           Auth.currentUser().then ->
             $location.path("/")
        ]
      ).when('/register',
        templateUrl: 'auth/_register.html'
        controller: 'AuthController',
        onEnter: [ '$scope', '$routeParams', '$location', '$resource','Auth',
         ($scope,$routeParams,$location,$resource, Auth)->
           Auth.currentUser().then ->
             $location.path("/")
        ]
      )
])

controllers = angular.module('controllers',[])
