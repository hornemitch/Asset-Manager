Template.body.helpers
  'userName': ->
    if Meteor.user()?.username
      toTitleCase Meteor.user()?.username

Template.body.events
  "click .sign-out" : () ->
    userName = toTitleCase Meteor.user().username

    setTimeout (->
      Meteor.logout( (error) ->
        if error
          console.log error
        else
          window.location = '/'
      )
    ), 3000

Template.default_layout.helpers
  'userLoggedIn': ->
    if Meteor.userId() != null
      return true
  'isAdmin' : ->
    if Meteor.user().username == 'Adminastrator'
      return true

Template.default_layout.events
  'click .logoutButton': (event)->
    event.preventDefault()

    conf = window.confirm('Are you sure you want to log out?')
    if conf == true
      Meteor.logout()
      Router.go 'default'