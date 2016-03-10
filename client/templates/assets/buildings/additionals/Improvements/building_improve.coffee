Template.building_improve.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.building_improve.helpers
  'selector': ->
    id = @_id
    return { buildingId: id }

Template.building_improve.events
  "click .removeButton" : (event) ->
    event.preventDefault()
    conf = window.confirm('Deleting this impairment will permanently delete all its data')
    if conf == true
      Meteor.call 'buildingImprovementRemove', @_id

Template.building_improve_create.onRendered ->
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
    field: document.getElementById 'datepicker'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker').val today

  $('.improvement-form').validate
    rules:
      improvementsValue:
        required: true
      improvementsDateOfRevalue:
        required: true
      improvementsDescription:
        required: true
    messages:
      improvementsValue:
        required: "Please enter the improvement's value"
      improvementsDateOfRevalue:
        required: "Please choose the date of the improvement"
      improvementsDescription:
        required: "Please describe the improvement"

Template.building_improve_create.events
  "submit .improvement-form" : (event) ->
    event.preventDefault()

    value         = event.target.improvementsValue.value
    dateOfImprove = event.target.improvementsDateOfRevalue.value
    description   = event.target.improvementsDescription.value

    Meteor.call 'buildingImprovement' , @_id,  value, dateOfImprove, description

    Router.go 'building.improve', _id:@_id