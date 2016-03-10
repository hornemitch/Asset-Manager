###
  * * * * * * * * * * * * * * * * * * *
    Cellphone Overview Report Creation
  * * * * * * * * * * * * * * * * * * *
###

Template.cellphone_report.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'reports'

Template.cellphone_report.helpers
  'cellphones': ->
    Meteor.subscribe 'cellphones'
    return Cellphones.find()

  'cellNumber': (number) ->
    return number.substr(0, 3) + '-' + number.substr(3, 3) + '-' + number.substr(6,4)

  'cellphoneCost': ->
    Meteor.subscribe 'cellphones'
    cellphones = Cellphones.find()

    totalCellphoneCost = 0

    cellphones.forEach (cellphone) ->
      totalCellphoneCost += parseFloat cellphone.costPrice

    return totalCellphoneCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'cellphoneCount': ->
    Meteor.subscribe 'cellphones'
    cellphones=Cellphones.find()
    count=0
    cellphones.forEach ->
      count++
    return count

Template.cellphone_report_print.onRendered ->
  window.print()
  Router.go 'cellphoneReport'

Template.cellphone_report_print.helpers
  'cellphones': ->
    Meteor.subscribe 'cellphones'
    return Cellphones.find()

  'cellNumber': (number) ->
    return number.substr(0, 3) + '-' + number.substr(3, 3) + '-' + number.substr(6,4)

  'cellphoneCost': ->
    Meteor.subscribe 'cellphones'
    cellphones = Cellphones.find()

    totalCellphoneCost = 0

    cellphones.forEach (cellphone) ->
      totalCellphoneCost += parseFloat cellphone.costPrice

    return totalCellphoneCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'cellphoneCount': ->
    Meteor.subscribe 'cellphones'
    cellphones=Cellphones.find()
    count=0
    cellphones.forEach ->
      count++
    return count