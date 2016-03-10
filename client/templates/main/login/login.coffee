Template.login.onRendered ->
  Session.set 'pastExpiration', false

  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'login'

  $('.login-form').validate()

Template.login.helpers
  isExpired: ->
    expired = Session.get 'pastExpiration'
    if expired == true
      return true

Template.login.events
  'submit .login-form': (event) ->
    event.preventDefault()

    userName = event.target.userN.value
    password = event.target.pass.value

    Meteor.loginWithPassword userName, password
    Router.go 'default'