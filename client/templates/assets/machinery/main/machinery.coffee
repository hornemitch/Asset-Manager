Template.machinery.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'machinery'

Template.machinery.helpers
  'machinery': ->
    return Machinery.find()
  'locations': ->
    return Locations.find()
  'hasLocations': ->
    Meteor.subscribe 'locations'
    hasloc = Locations.find()
    if hasloc.count() == 0
      return false
    else
      return true
  'hasCategory': ->
    Meteor.subscribe 'machine_category'
    cate = Machine_Category.find()
    if cate.count() == 0
      return false
    else
      return true

Template.machinery.events
  'click .removeButton': ->
    conf = window.confirm('Deleting this machine will permanently delete all of its data')
    if conf == true
      Meteor.call "deleteMachine", @_id, @assetPicture, @invoiceScan