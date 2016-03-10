Template.cellphone_month.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'cellphones'

Template.cellphone_month.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'cellphones'

Template.cellphone_month.helpers
  'selector': ->
    id = @_id
    return { cellphoneId: id }

  'isSubscriptionCell': ->
    contractCell = @hasContract
    if contractCell == true
      return true
    else
      return false

  'cellNumber': (number) ->
      return number.substr(0, 3) + '-' + number.substr(3, 3) + '-' + number.substr(6,4)

Template.cellphone_month.events
  'click .removeButton': (event) ->
    event.preventDefault()
    conf = window.confirm('Deleting this month will permanently delete all its data')
    if conf == true
      Meteor.call 'deleteMonth', @_id