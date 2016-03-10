Template.read_furniture_detail.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'furniture'

Template.read_furniture_detail.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'decDep': ->
    Meteor.subscribe 'usefulLife'
    furniture = UsefulLife.findOne name:'Furniture'
    depreciation = parseFloat furniture.depreciation
    return depreciation.toFixed(2)

  'bookValue': ->
    Meteor.subscribe 'usefulLife'
    furniture = UsefulLife.findOne name:'Furniture'
    depreciation = parseFloat furniture.depreciation

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
    bookValue= parseFloat(bookValue).toFixed(2)
    return bookValue