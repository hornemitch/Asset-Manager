Template.create_building.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.create_building.onRendered ->
  Session.set 'isFactory', false

  picker = new Pikaday (
    field: document.getElementById 'datepicker'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker').val today

  $('.addBuilding').validate
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

Template.create_building.helpers
  'locations': ->
    Meteor.subscribe 'locations'
    return Locations.find()
  'isFactory':->
    return Session.get 'isFactory'

Template.create_building.events
  'submit .addBuilding': (event) ->
    event.preventDefault()

    purchaseCost         = event.target.purchaseCost.value
    purchaseDate         = event.target.purchaseDate.value
    propertyId           = event.target.propertyNumber.value
    locate               = event.target.location.value
    buildingName         = event.target.buildingName.value
    user                 = Meteor.user().username
    description          = event.target.description.value
    type                 = Session.get 'isFactory'

    Meteor.call 'addBuilding', purchaseCost, purchaseDate, propertyId, locate, buildingName, user, description,type
    Router.go 'buildings'

  'click .is-factory':->
    Session.set 'isFactory', true
  'click .is-not-factory':->
    Session.set 'isFactory', false