###
  * * * * * * * * * * * * * * * * * * *
    Computer Overview Report Creation
  * * * * * * * * * * * * * * * * * * *
###

Template.computer_report.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'reports'

Template.computer_report.helpers
  'computers': ->
    Meteor.subscribe 'computers'
    return Computers.find()

  'computerCost': ->
    Meteor.subscribe 'computers'
    computers = Computers.find()

    totalComputerCost = 0

    computers.forEach (computer) ->
      totalComputerCost += parseFloat computer.costPrice

    return totalComputerCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'computerCount': ->
    Meteor.subscribe 'computers'
    computers=Computers.find()
    count=0
    computers.forEach ->
      count++
    return count

Template.computer_report_print.onRendered ->
  window.print()
  Router.go 'computerReport'

Template.computer_report_print.helpers
  'computers': ->
    Meteor.subscribe 'computers'
    return Computers.find()

  'computerCost': ->
    Meteor.subscribe 'computers'
    computers = Computers.find()

    totalComputerCost = 0

    computers.forEach (computer) ->
      totalComputerCost += parseFloat computer.costPrice

    return totalComputerCost

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'computerCount': ->
    Meteor.subscribe 'computers'
    computers=Computers.find()
    count=0
    computers.forEach ->
      count++
    return count