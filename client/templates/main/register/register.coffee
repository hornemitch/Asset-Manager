Meteor.subscribe 'companies'

Template.register.helpers
  'isAdmin' : ->
    user = Meteor.user().username
    if user == 'Adminastrator'
      return true
  'company': ->
    Companies.find()

Template.register.events
  'submit .register-form': (event) ->
    event.preventDefault()

    admin       = Meteor.user().username
    adminPass   = event.target.adminPass.value
    userName    = event.target.name.value
    password    = event.target.pass.value
    today       = new Date()
    yearFromNow = new Date(new Date().setYear(new Date().getFullYear() + 1))

    Meteor.call 'addUser', admin, adminPass, userName, password, today, yearFromNow

    event.target.adminPass.value = ''
    event.target.name.value      = ''
    event.target.pass.value      = ''

Template.register_company.helpers
  'isAdmin' : ->
    user = Meteor.user().username
    if user == 'Adminastrator'
      return true
  'company': ->
    Companies.find()

Template.register_company.events
  'submit .register-company-form': (event) ->
    event.preventDefault()

    coName    = event.target.coName.value

    Meteor.call 'addCompany', coName

    event.target.coName.value = ''