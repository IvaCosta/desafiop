controllers = angular.module('controllers')
controllers.controller("AuthController", [ '$scope', '$routeParams', '$location', '$resource','Auth',
  ($scope,$routeParams,$location,$resource, Auth)->
    $scope.login = ->
      Auth.login($scope.user).then ->
        $location.path("/")
		
    $scope.register = ->
      Auth.register($scope.user).then ->
        $location.path("/")		    		
      
    $scope.logout = ->
      Auth.logout($scope.user).then ->
        $location.path("/")		  
])