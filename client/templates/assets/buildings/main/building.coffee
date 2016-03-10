#***Building main on render actions****
Template.building.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

#***Building main helpers****
Template.building.helpers
  'hasLocations': ->
    Meteor.subscribe 'locations'
    hasloc = Locations.find()
    if hasloc.count() == 0
      return false
    else
      return true

#***Building main events***
Template.building.events
  'click .removeButton': ->

    conf = window.confirm('Deleting this buildings will permanently delete the data')
    if conf == true
      Meteor.call 'deleteBuilding', @_id, @assetPicture, @registrationDocument, @purchaseContract

  'click .addButton': (event) ->
    event.preventDefault()
    Router.go 'building.add'

  'click .hideDetails' : ->
    Session.set 'details', false
  'click .showDetails' : ->
    Session.set 'details', true