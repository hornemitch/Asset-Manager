Template.vehicle.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'vehicles'

Template.vehicle.helpers
  'vehicles': ->
    return Vehicles.find()
  'hasLocations': ->
    Meteor.subscribe 'locations'
    hasloc = Locations.find()
    if hasloc.count() == 0
      return false
    else
      return true
  'hasCategory': ->
    Meteor.subscribe 'vehicle_category'
    cate = Vehicle_Category.find()
    if cate.count() == 0
      return false
    else
      return true

Template.vehicle.events
  'click .removeButton': ->
    conf = window.confirm('Are You Sure You Want To Delete This Vehicle?')
    if conf == true
      Meteor.call "deleteVehicle", @_id, @invoiceScan, @assetPicture

  'click .addButton': ->
    Router.go 'vehicle.create'