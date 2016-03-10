Template.users.helpers
  'user': ->
    Meteor.subscribe 'users'
    Meteor.users.find()
  'isAdmin' : ->
    user = Meteor.user().username
    if user == 'Adminastrator'
      return true

Template.users.events
  'click .deleteButton': ->
    meteor.users.remove _id:this._id