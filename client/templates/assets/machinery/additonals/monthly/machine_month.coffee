Template.machine_month.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'machinery'

Template.machine_month.helpers
  'selector': ->
    id = @_id
    return { machineId: id }

Template.machine_month.events
  'click .removeButton': (event) ->
    event.preventDefault()
    conf = window.confirm('Deleting this month will permanently delete all of its data')
    if conf == true
      id = @_id
      Meteor.call "deleteMachineMonth", id

Template.machine_month_create.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'machinery'

Template.machine_month_create.onRendered ->
  picker = new Pikaday (
    field: document.getElementById 'datepicker'
    format : 'MM-YYYY'
  )
  today = moment().format 'MM-YYYY'
  $('#datepicker').val today


  $('.machinery-month-form').validate
    rules:
      month :
        required : true
      maintenance :
        required : true
      revaluation :
        required : true

    messages:
      month :
        required : "Please choose the month"
      maintenance :
        required : "Please enter the machine's maintenance cost for the month"
      revaluation :
        required : "Please enter the machine's current value"

Template.machine_month_create.events
  'submit .machinery-month-form': (event)->
    event.preventDefault()

    id          =  @_id
    month       = event.target.month.value
    maintenance = event.target.maintenance.value
    revaluation = event.target.revaluation.value

    Meteor.call 'addMachineMonth', id, month, maintenance, revaluation
    Router.go 'machine.month', _id:@_id

  'click .backButton': (event)->
    event.preventDefault()
    Router.go 'machine.month', _id:@_id