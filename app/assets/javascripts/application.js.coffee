#= require jquery
#= require jquery_ujs
#  require bootstrap-sprockets
#= require momentjs/moment
#= require livestampjs/livestamp
#= require angular/angular
#= require_tree .

window.App = angular.module 'App', []

App.controller 'WhoToFollowController', [
  '$http', ($http) ->
    ctrl = @
    ctrl.users = []
    $http.get '/who_to_follow.json'
      .then (response) ->
        ctrl.users = response.data
        return
    return
  ]