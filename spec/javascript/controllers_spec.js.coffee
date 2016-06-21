describe "Subscriber controllers", ->
  beforeEach module("newsletter")

  describe "SubscribersController", ->
    it "should set subscribers to an empty array", inject(($controller) ->
      scope = {}
      ctrl = $controller("SubscribersController",
        $scope: scope
      )
      expect(scope.subscribers.length).toBe 0
    )