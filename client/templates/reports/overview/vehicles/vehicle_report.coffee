###
  * * * * * * * * * * * * * * * * * * *
    Computer Overview Report Creation
  * * * * * * * * * * * * * * * * * * *
###

Template.vehicle_report.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'reports'

Template.vehicle_report.helpers
  'vehicles': ->
    Meteor.subscribe 'vehicles'
    return Vehicles.find()

  'vehicleCategory': (vehicleCategory) ->
    Meteor.subscribe 'vehicle_category'
    vehiclecat = Vehicle_Category.findOne(vehicleCategory)
    return vehiclecat.name

  'vehicleCost': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()

    totalVehicleCost = 0

    vehicles.forEach (vehicle) ->
      totalVehicleCost += parseFloat vehicle.costPrice

    return totalVehicleCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'vehicleCount': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()
    count = 0
    vehicles.forEach ->
      count++
    return count

Template.vehicle_report_print.onRendered ->
  window.print()
  Router.go 'vehicleReport'

Template.vehicle_report_print.helpers
  'computers': ->
    Meteor.subscribe 'vehicles'
    return Vehicles.find()

  'vehicleCategory': (vehicleCategory) ->
    Meteor.subscribe 'vehicle_category'
    vehiclecat = Vehicle_Category.findOne(vehicleCategory)
    return vehiclecat.name

  'vehicleCost': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()

    totalVehicleCost = 0

    vehicles.forEach (vehicle) ->
      totalVehicleCost += parseFloat vehicle.costPrice

    return totalVehicleCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'vehicleCount': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()
    count = 0
    vehicles.forEach ->
      count++
    return count