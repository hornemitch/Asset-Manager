Template.computer_useful_life_update.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computer-life'

Template.computer_useful_life_update.onRendered ->
  $('.input-form').validate
    rules:
      lifeValue:
        required: true
    messages:
      lifeValue:
        required: 'Please enter the new useful life'

Template.computer_useful_life_update.helpers
  'depcap': ->
    depreciation = @depreciation.toFixed(2)
    return depreciation

Template.computer_useful_life_update.events
  'submit .useful-life-form': (event)->
    event.preventDefault()

    life = event.target.lifeValue.value

    Meteor.call 'updateComputerLife', life
    Router.go 'computers'