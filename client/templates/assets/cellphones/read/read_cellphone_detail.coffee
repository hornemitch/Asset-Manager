Template.read_cellphone_detail.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'cellphones'

Template.read_cellphone_detail.helpers
  'hasContract': ->
    if @contractEnd != null
      return true
    else
      return false

  'cellNumber': (number) ->
    return number.substr(0, 3) + '-' + number.substr(3, 3) + '-' + number.substr(6,4)

  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'showDataValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(3)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'decDep': ->
    Meteor.subscribe 'usefulLife'
    cellphone = UsefulLife.findOne name:'Cellphones'
    depreciation = parseFloat cellphone.depreciation
    return depreciation.toFixed(2)

  'bookValue': ->
    Meteor.subscribe 'usefulLife'
    cellphone = UsefulLife.findOne name:'Cellphones'
    depreciation = parseFloat cellphone.depreciation

    buyDate  = @purchaseDate
    split    = buyDate.split('-')
    oldmonth = split[1]
    oldYear  = split[2]
    nowdate  = new Date()
    newMonth = nowdate.getMonth() + 1
    newYear  = nowdate.getFullYear()
    months = (newYear - oldYear)*12 + (newMonth - oldmonth)

    totalDepreciation =(@costPrice * (depreciation/100/12 * months))
    bookValue= @costPrice - totalDepreciation

    if bookValue <= 1
      return '1.00'
    else
      bookValue= parseFloat(bookValue).toFixed(2)
      return bookValue