Template.read_machinery_detail.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'machinery'

Template.read_machinery_detail.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'categoryName': ->
    Meteor.subscribe 'machine_category'
    category = Machine_Category.findOne @category
    return category.name

  'decDep': ->
    category = Machine_Category.findOne @category
    depreciation = category.depreciation
    return parseFloat(Math.round(depreciation * 100) / 100).toFixed(2)

  'usefulLife': ->
    category = Machine_Category.findOne @category
    return category.usefulLife

  'bookValue': ->
    category = Machine_Category.findOne @category

    buyDate  = @purchaseDate
    split    = buyDate.split('-')

    oldmonth = split[1]
    oldYear  = split[2]

    nowdate       = new Date()
    newMonth      = nowdate.getMonth() + 1
    newYear       = nowdate.getFullYear()

    months = (newYear - oldYear)*12 + (newMonth - oldmonth)
    totalDepreciation =(@costPrice * (category.depreciation/100/12 * months))
    bookValue= @costPrice - totalDepreciation
    bookValue= parseFloat(bookValue).toFixed(2)

    return bookValue

  'getCategory': ->
    Machine_Category.find @category