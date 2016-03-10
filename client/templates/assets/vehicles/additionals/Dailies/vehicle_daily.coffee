Template.vehicle_daily.helpers
  'selector': ->
    id = @_id
    return { vehicleId: id }

Template.vehicle_daily.events
  'click .removeButton': (event) ->
    event.preventDefault()
    parent = Template.parentData(1)
    id     = parent._id

    conf = window.confirm 'Deleting this daily will permanently delete all its data'
    if conf == true
      conf2 = window.confirm "Do you want to reset this vehicles odometer reading to this daily's last reading"
      if conf2 == true
        Meteor.call 'odometerReset', id, @currentOdometer
        Meteor.call 'deleteVehicleDaily', @_id
      else
        Meteor.call 'deleteVehicleDaily', @_id

Template.vehicle_daily_create.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'vehicles'

  picker = new Pikaday (
    field: document.getElementById 'datepicker'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker').val today

  $('.vehicle-daily-form').validate
    rules:
      day :
        required : true
      odometer :
        required : true

    messages:
      day :
        required : "Please choose the date for the recording"
      odometer :
        required : "Please enter the current odometer reading"

Template.vehicle_daily_create.events
  'submit .vehicle-daily-form': (event)->
    event.preventDefault()

    id       = @_id
    odo      = @odometerCurrent
    day      = event.target.day.value
    odometer = event.target.odometer.value
    comment  = event.target.comment.value

    Meteor.call 'addVehicleDaily', id, odo, day, odometer, comment
    Router.go 'vehicle.daily', _id:@_id

  'click .backButton': (event)->
    event.preventDefault()
    Router.go 'vehicle.daily', _id:@_id