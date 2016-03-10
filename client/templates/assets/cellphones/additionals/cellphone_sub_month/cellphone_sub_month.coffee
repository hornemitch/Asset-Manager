Template.cellphone_sub_month_detail.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

Template.cellphone_sub_month_detail.events
  'click .backButton': (event) ->
    event.preventDefault()
    id = @cellphoneId
    Router.go 'cellphone.monthly', _id:id

Template.cellphone_sub_month_create.helpers
  'cellNumber': (number) ->
    return number.substr(0, 3) + '-' + number.substr(3, 3) + '-' + number.substr(6,4)

Template.cellphone_sub_month_detail.onRendered ->
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
      subscriptionTotal:
        required: true
      callsCost:
        required: true
      dataCost:
        required: true
      other:
        required: true
    messages:
      month:
        required: 'Please choose a month'
      subscriptionTotal:
        required: "Please enter the month's normal subscription cost"
      callsCost:
        required: "Please enter the month's calls cost"
      dataCost:
        required: "Please enter the month's data cost"
      other:
        required: 'Please enter total other costs that occurred this month'

Template.cellphone_sub_month_create.events
  'submit .cellphone-month-form' : (event) ->
    event.preventDefault()

    Month             = event.target.month.value
    subscriptionTotal = event.target.subscriptionTotal.value
    callsCost         = parseFloat(event.target.callsCost.value)
    dataServices      = parseFloat(event.target.dataCost.value)
    other             = parseFloat(event.target.other.value)
    comment           = event.target.comment.value

    total = callsCost + dataServices + other

    Meteor.call 'addCellphoneSubMonth', @_id, Month, subscriptionTotal, callsCost, dataServices, other, total, comment

    Router.go 'cellphone.monthly', _id:@_id