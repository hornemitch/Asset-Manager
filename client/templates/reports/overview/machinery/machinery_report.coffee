###
  * * * * * * * * * * * * * * * * * * * *
    Machinery Overview Report Creation
  * * * * * * * * * * * * * * * * * * * *
###

Template.machinery_report.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'reports'

Template.machinery_report.helpers
  'machinery': ->
    Meteor.subscribe 'machinery'
    return Machinery.find()

  'machineCategory': (machineCategory) ->
    Meteor.subscribe 'machine_category'
    machinecat = Machine_Category.findOne(machineCategory)
    return machinecat.name

  'machineryCost': ->
    Meteor.subscribe 'machinery'
    machinery = Machinery.find()

    totalMachineCost = 0

    machinery.forEach (machine) ->
      totalMachineCost += parseFloat machine.costPrice

    return totalMachineCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'machineryCount': ->
    Meteor.subscribe 'machinery'
    machinery=Machinery.find()
    count=0
    machinery.forEach ->
      count++
    return count

Template.machinery_report_print.onRendered ->
  window.print()
  Router.go 'machineryReport'

Template.machinery_report_print.helpers
  'machinery': ->
    Meteor.subscribe 'machinery'
    return Machinery.find()

  'machineCategory': (machineCategory) ->
    Meteor.subscribe 'machine_category'
    machinecat = Machine_Category.findOne(machineCategory)
    return machinecat.name

  'machineryCost': ->
    Meteor.subscribe 'machinery'
    machinery = Machinery.find()

    totalMachineCost = 0

    machinery.forEach (machine) ->
      totalMachineCost += parseFloat machine.costPrice

    return totalMachineCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'machineryCount': ->
    Meteor.subscribe 'machinery'
    machinery=Machinery.find()
    count=0
    machinery.forEach ->
      count++
    return count