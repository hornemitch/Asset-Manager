Meteor.startup ->
  smoothScroll.init
    speed: 0
    offset: 50
    callback: (toggle, anchor) ->
  return

# * * Capitalise first letter function  * *
@toTitleCase = (str) ->
  str.replace /\w\S*/g, (txt) ->
    txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

# * * Login configuration  * *
Accounts.ui.config
  passwordSignupFields: "USERNAME_ONLY"

# * * Validation method adding * *
jQuery.validator.addMethod 'cellNumber', ((number) ->
  numberTest = /^\d{10}$/
  if(number.match(numberTest))
    return true
  else
    return false
), 'Please enter a valid 10 digit number'