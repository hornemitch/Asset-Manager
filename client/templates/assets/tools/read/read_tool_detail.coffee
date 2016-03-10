Template.read_tool_detail.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'categoryName': ->
    category = Tool_Category.findOne @category
    return category.name

  'isCalibrated': ->
    if @calibrationDate == null
      return false
    else
      return true

  'decDep': ->
    Meteor.subscribe 'tool_category'
    category = Tool_Category.findOne @category
    return parseFloat(Math.round(category.depreciation * 100) / 100).toFixed(2)

  'bookValue': ->
    Meteor.subscribe 'tool_category'
    category = Tool_Category.findOne @category

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