###
  * * * * * * * * * * * * * * * * * * *
    Tool Overview Report Creation
  * * * * * * * * * * * * * * * * * * *
###

Template.tool_report.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'reports'

Template.tool_report.helpers
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

  'tools': ->
    Meteor.subscribe 'tools'
    return Tools.find()

  'toolCategory': (toolCategory) ->
    Meteor.subscribe 'tool_category'
    toolcat = Tool_Category.findOne(toolCategory)
    return toolcat.name

  'toolCost': ->
    Meteor.subscribe 'tools'
    tools = Tools.find()

    totalToolCost = 0

    tools.forEach (tool) ->
      totalToolCost += parseFloat tool.costPrice

    totalToolCost = totalToolCost.toFixed(2)
    return totalToolCost

  'toolCount': ->
    Meteor.subscribe 'tools'
    tools=Tools.find()
    count=0
    tools.forEach ->
      count++
    return count

Template.tool_report_print.onRendered ->
  window.print()
  Router.go 'toolReport'

Template.tool_report_print.helpers
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

  'tools': ->
    Meteor.subscribe 'tools'
    return Tools.find()

  'toolCategory': (toolCategory) ->
    Meteor.subscribe 'tool_category'
    toolcat = Tool_Category.findOne(toolCategory)
    return toolcat.name

  'toolCost': ->
    Meteor.subscribe 'tools'
    tools = Tools.find()

    totalToolCost = 0

    tools.forEach (tool) ->
      totalToolCost += parseFloat tool.costPrice

    totalToolCost = totalToolCost.toFixed(2)
    return totalToolCost

  'toolCount': ->
    Meteor.subscribe 'tools'
    tools=Tools.find()
    count=0
    tools.forEach ->
      count++
    return count