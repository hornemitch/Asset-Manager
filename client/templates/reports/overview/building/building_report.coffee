###
  * * * * * * * * * * * * * * * * * * *
    Building Overview Report Creation
  * * * * * * * * * * * * * * * * * * *
###

Template.building_report.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'reports'

Template.building_report.helpers
  'showCostValue': (number) ->
    number = parseFloat number
    number = number.toFixed(2)
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'buildings': ->
    Meteor.subscribe 'buildings'
    return Buildings.find()

  'buildingCost': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildingCost = 0

    buildings.forEach (building) ->
      totalBuildingCost += parseFloat building.purchaseCost

    totalBuildingCost = totalBuildingCost.toFixed(2)
    return totalBuildingCost

  'buildingValue': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildingValue = 0

    buildings.forEach (building) ->
      totalBuildingValue += parseFloat building.currentValue

    totalBuildingValue = totalBuildingValue.toFixed(2)
    return totalBuildingValue

  'buildingCount': ->
    Meteor.subscribe 'buildings'
    buildings=Buildings.find()
    count = 0
    buildings.forEach ->
      count++
    return count

Template.building_report_print.onRendered ->
  window.print()
  Router.go 'buildingReport'

Template.building_report_print.helpers
  'showCostValue': (number) ->
    number = parseFloat number
    number = number.toFixed(2)
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'buildings': ->
    Meteor.subscribe 'buildings'
    return Buildings.find()

  'buildingCost': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildingCost = 0

    buildings.forEach (building) ->
      totalBuildingCost += parseFloat building.purchaseCost

    totalBuildingCost = totalBuildingCost.toFixed(2)
    return totalBuildingCost

  'buildingValue': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildingValue = 0

    buildings.forEach (building) ->
      totalBuildingValue += parseFloat building.currentValue

    totalBuildingValue = totalBuildingValue.toFixed(2)
    return totalBuildingValue

  'buildingCount': ->
    Meteor.subscribe 'buildings'
    buildings=Buildings.find()
    count = 0
    buildings.forEach ->
      count++
    return count