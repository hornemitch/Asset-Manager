Template.building_revalue.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.building_revalue.helpers
  'selector': ->
    id = @_id
    return { buildingId: id }

Template.building_revalue.events
  'click .removeButton' : (event) ->
    event.preventDefault()
    parent = Template.parentData(1)
    id    = parent._id

    conf = window.confirm 'Deleting this revaluation will permanently delete all its data'
    if conf == true
      conf2 = window.confirm("Do You Want to Reset the Building's Value to this Revaluation's Previous Value?")
      if conf2 == true
        Meteor.call 'resetBuildingValue', id, @prevValue
        Meteor.call 'buildingRevalateRemove', @_id
      else
        Meteor.call 'buildingRevalateRemove', @_id

Template.building_revalue_create.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.building_revalue_create.onRendered ->
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

  $('.revaluation-form').validate
    rules:
      value:
        required: true
      dateOfRevalue:
        required: true
    messages:
      value:
        required: 'Please enter the revaluation value'
      dateOfRevalue:
        required: "Please choose the date of the revaluation"

  Session.set 'revalueCertificate', null

Template.building_revalue_create.events
  "submit .revaluation-form" : (event) ->
    event.preventDefault()

    value                  = event.target.value.value
    dateOfRevalue          = event.target.dateOfRevalue.value

    buildingPrevValue = @currentValue

    Meteor.call "buildingRevaluate" , @_id,  value, dateOfRevalue, buildingPrevValue
    Router.go 'buildings'