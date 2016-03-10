Template.building_impair.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.building_impair.helpers
  'selector': ->
    id = @_id
    return { buildingId: id }

Template.building_impair.events
  "click .removeButton" : (event) ->
    event.preventDefault()
    conf = window.confirm('Deleting this impairment will permanently delete all its data')
    if conf == true
      Meteor.call 'buildingImpairmentRemove', @_id

Template.building_impair_create.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.building_impair_create.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

  win = $(window)
  if win.width() > 1441
    $('#buildingCreateDiv').addClass 'col-md-8'
    $('#buildingCreateDiv').addClass 'col-md-offset-2'
  else
    $('#buildingCreateDiv').addClass 'col-md-10'
    $('#buildingCreateDiv').addClass 'col-md-offset-1'

  picker = new Pikaday (
    field  : document.getElementById 'datepicker'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker').val today

  $('.impairment-form').validate
    rules:
      impairmentsValue:
        required: true
      impairmentsDateOfRevalue:
        required: true
      impairmentsDescription:
        required: true
    messages:
      impairmentsValue:
        required: "Please enter the impairment's value"
      impairmentsDateOfRevalue:
        required: "Please choose the date of the impairment"
      impairmentsDescription:
        required: "Please describe the impairment"

Template.building_impair_create.events
  'submit .impairment-form' : (event) ->
    event.preventDefault()

    value        = event.target.impairmentsValue.value
    dateOfImpair = event.target.impairmentsDateOfRevalue.value
    description  = event.target.impairmentsDescription.value

    Meteor.call "buildingImpairment" , @_id,  value, dateOfImpair, description

    Router.go 'building.impair', _id:@_id