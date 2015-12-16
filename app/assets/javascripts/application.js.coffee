#= require jquery
#= require jquery_ujs
#  require bootstrap-sprockets
#= require momentjs/moment
#= require livestampjs/livestamp
#= require angular/angular
#= require_tree .

window.App = angular.module 'App', []

App.controller 'WhoToFollowController', [
  '$http',
  ($http) ->
    ctrl = @

    ctrl.users = []

    $http.get '/who_to_follow.json'
      .then (response) ->
        ctrl.users = response.data
        return

    ctrl.follow = (user) ->
      $http.post '/users/follow.json', id: user.id
        .then ->
          user.following = true
          return
      return

    ctrl.unfollow = (user) ->
      $http.post '/users/unfollow.json', id: user.id
        .then ->
          user.following = false
          return
      return

    return
  ]