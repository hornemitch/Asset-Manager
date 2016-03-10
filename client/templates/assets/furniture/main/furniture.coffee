Template.furniture.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'furniture'

Template.furniture.helpers
  'furniture': ->
    return Furniture.find()
  'locations': ->
    return Locations.find()
  'hasLocations': ->
    Meteor.subscribe 'locations'
    hasloc = Locations.find()
    if hasloc.count() == 0
      return false
    else
      return true

Template.furniture.events
  'click .removeButton': ->
    conf = window.confirm('Deleting this furniture will permanently delete all its data')
    if conf == true
      Meteor.call "deleteFurniture", @_id

  'click .addButton': (event) ->
    event.preventDefault()
    Router.go 'furniture.create'