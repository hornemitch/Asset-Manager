Template.cellphone_no_sub_month_detail.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

Template.cellphone_no_sub_month_detail.events
  'click .backButton': (event) ->
    event.preventDefault()
    id = @cellphoneId
    Router.go 'cellphone.monthly', _id:id

Template.cellphone_no_sub_month_detail.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'cellphones'

  picker = new Pikaday (
    field: document.getElementById 'datepicker'
    format : 'MMM-YYYY'
  )
  today = moment().format 'MMM-YYYY'
  $('#datepicker').val today

  $('.cellphone-month-form').validate
    rules:
      month:
        required: true
      airtimeCosts:
        required: true
      dataCosts:
        required: true
    messages:
      month:
        required: 'Please choose a month'
      airtimeCosts:
        required: "Please enter the month's airtime cost"
      dataCosts:
        required: "Please enter the month's data cost"

Template.cellphone_no_sub_month_create.helpers
  'cellNumber': (number) ->
    return number.substr(0, 3) + '-' + number.substr(3, 3) + '-' + number.substr(6,4)

Template.cellphone_no_sub_month_create.events
  'submit .cellphone-month-form' : (event) ->
    event.preventDefault()

    Month        = event.target.month.value
    airtimeCosts = parseFloat(event.target.airtimeCosts.value)
    dataCosts    = parseFloat(event.target.dataCosts.value)
    comment      = event.target.comment.value

    total = airtimeCosts+  dataCosts

    Meteor.call 'addCellphoneNoSubMonth', @_id, Month, airtimeCosts, dataCosts, total, comment

    Router.go 'cellphone.monthly', _id:@_id