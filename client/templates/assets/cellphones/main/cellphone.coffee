Template.cellphone.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'cellphones'

Template.cellphone.helpers
  'cellphones': ->
    return Cellphones.find()

  'hasLocations': ->
    Meteor.subscribe 'locations'
    hasloc = Locations.find()
    if hasloc.count() == 0
      return false
    else
      return true

Template.cellphone.events
  'click .removeButton': ->
    conf = window.confirm('Deleting this cellphone will permanently delete this asset and all its data')
    if conf == true
      Meteor.call "deleteCellphone", @_id, @invoiceScan, @assetPicture