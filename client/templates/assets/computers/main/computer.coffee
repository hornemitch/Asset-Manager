Template.computer.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computers'

Template.computer.helpers
  'computers': ->
    Meteor.subscribe 'locations'
    return Computers.find()
  'hasLocations': ->
    Meteor.subscribe 'locations'
    hasloc = Locations.find()
    if hasloc.count() == 0
      return false
    else
      return true

Template.computer.events
  'click .removeButton': ->
    conf = window.confirm('Deleting this computer will permanently delete its data')
    if conf == true
      Meteor.call "deleteComputer", @_id

  'click .addButton': (event) ->
    event.preventDefault()
    Router.go 'computer.create'