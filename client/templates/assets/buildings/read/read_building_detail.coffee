Template.read_building_details.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'buildings'

Template.read_building_details.helpers
  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'buildingType': ->
    if @type == true
      return 'Manufacturing Building'
    else
      return 'Non-Manufacturing Building'

  'manu': ->
    return @type

  'decDep': ->
    Meteor.subscribe 'usefulLife'
    building = UsefulLife.findOne name:'Buildings'
    depreciation = parseFloat building.depreciation
    return depreciation.toFixed(2)

  'bookValue': ->
    Meteor.subscribe 'usefulLife'
    building = UsefulLife.findOne name:'Buildings'
    depreciation = parseFloat building.depreciation

    buyDate  = @purchaseDate
    split    = buyDate.split('-')
    oldmonth = split[1]
    oldYear  = split[2]
    nowdate  = new Date()
    newMonth = nowdate.getMonth() + 1
    newYear  = nowdate.getFullYear()
    months = (newYear - oldYear)*12 + (newMonth - oldmonth)

    totalDepreciation =(@purchaseCost * (depreciation/100/12 * months))
    bookValue= @purchaseCost - totalDepreciation
    if bookValue <= 1
      return '1.00'
    else
      bookValue= parseFloat(bookValue).toFixed(2)
      return bookValue

Template.read_building_details.events
  'click .destroyButton': (event) ->
    event.preventDefault()

    dest = window.confirm('Only accept this if the buildings is no longer usable. This marks the buildings as destroyed permanently')
    if dest
      Meteor.call 'buildingDestroyed', @_id