Template.cellphonePurchase.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

Template.cellphoneNumber.helpers
  'cellNumber': (number) ->
    return number.substr(0, 3) + '-' + number.substr(3, 3) + '-' + number.substr(6,4)