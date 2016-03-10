Template.cellphoneMonthSubDifference.helpers
  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else ''
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

Template.cellphoneMonthSubscription.helpers
  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else ''
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

Template.cellphoneMonthSubTotal.helpers
  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else ''
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2