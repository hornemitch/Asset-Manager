Template.vehicleDailyLastOdo.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(3)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

Template.vehicleDailyCurrOdo.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(3)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

Template.vehicleDailyDistance.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(3)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")