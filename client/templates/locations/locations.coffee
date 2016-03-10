Template.location.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'locations'

Template.location.helpers
  'locations': ->
    return Locations.find()

Template.location.events

  'click .addButton': (event) ->
    event.preventDefault()
    Router.go 'location.create'