Template.update_building.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.update_building.onRendered ->
  if @.data.type == true
    Session.set 'isFactory', true
  else
    Session.set 'isFactory', false

  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

  picker = new Pikaday (
    field: document.getElementById 'datepicker'
    format : 'DD-MM-YYYY'
  )

  $('.input-form').validate
    rules:
      buildingName:
        required: true
      propertyNumber:
        required: true
      purchaseDate:
        required: true
      purchaseCost:
        required: true
      description:
        required: true
    messages:
      buildingName:
        required: 'Please enter the building name'
      propertyNumber:
        required: "Please enter the property's identification number"
      purchaseDate:
        required: 'Please choose a purchase date'
      purchaseCost:
        required: "Please enter the building's purchase price"
      description:
        required: 'Please describe the building'

Template.update_building.helpers
  'isCurrentState' : (state) ->
    return @status == state
  'myID' : ->
    Session.set 'theID', @locate
    return Session.get 'theID'
  'locations': ->
    Meteor.subscribe 'locations'
    buildSite = Session.get 'theID'
    {
      places : Locations.find()
      buildingSite : buildSite
    }
  'isFactory':->
    return Session.get 'isFactory'

Template.update_building.events
  'submit .building-edit-form' : (event) ->
    event.preventDefault()
    buildingName = event.target.buildingName.value
    status       = event.target.status.value
    purchaseCost = event.target.purchaseCost.value
    purchaseDate = event.target.purchaseDate.value
    propertyId   = event.target.propertyId.value
    locate       = event.target.locateSelect.value
    description  = event.target.description.value
    type         = Session.get 'isFactory'

    Meteor.call 'editBuilding' , @_id, buildingName, status, purchaseCost, purchaseDate, propertyId, locate, description, type
    Router.go 'buildings'

  'click .is-factory':->
    Session.set 'isFactory', true
  'click .is-not-factory':->
    Session.set 'isFactory', false

Template.location_building_option.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.locate
    return @siteName == buildSite