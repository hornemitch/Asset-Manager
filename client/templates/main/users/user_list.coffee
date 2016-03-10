Template.user_list.onCreated ->
  @.changePasswordvar = new ReactiveVar false

Template.user_list.helpers
  'changePass': ->
    return Template.instance().changePasswordvar.get()
  'notAdmin': ->
    if @.username == 'Adminastrator'
      return false
    else
      return true

Template.user_list.events
  'submit .pass-reset': (event) ->
    event.preventDefault()

    newPass    = event.target.pass.value

    Meteor.call 'changeMyPassword', @_id, newPass

    event.target.pass.value = ''

  'click .changePassword': (event, Template) ->
    event.preventDefault()
    Template.changePasswordvar.set true

  'click .notChange': (event, Template) ->
    event.preventDefault()
    Template.changePasswordvar.set false

  'click .deleteAccount': (event) ->
    event.preventDefault()
    Meteor.users.remove @_id