Template.read_vehicle_detail.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'categoryName': ->
    Meteor.subscribe 'vehicle_category'
    category = Vehicle_Category.findOne @category
    return category.name

  'decDep': ->
    Meteor.subscribe 'vehicle_category'
    category = Vehicle_Category.findOne @category
    depreciation = parseFloat category.depreciation
    return depreciation.toFixed(2)

  'bookValue': ->
    Meteor.subscribe 'vehicle_category'
    category  = Vehicle_Category.findOne @category

    buyDate   = @purchaseDate
    split     = buyDate.split('-')
    oldmonth  = split[1]
    oldYear   = split[2]
    nowdate   = new Date()
    newMonth  = nowdate.getMonth() + 1
    newYear   = nowdate.getFullYear()
    months    = (newYear - oldYear)*12 + (newMonth - oldmonth)

    totalDepreciation =(@costPrice * (category.depreciation/100/12 * months))
    bookValue = @costPrice - totalDepreciation
    bookValue = parseFloat(bookValue).toFixed(2)
    return bookValue