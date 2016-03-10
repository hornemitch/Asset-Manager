Template.update_vehicle.onRendered ->
  picker = new Pikaday (
    field: document.getElementById 'datepicker1'
    format : 'DD-MM-YYYY'
  )

  picker = new Pikaday (
    field: document.getElementById 'datepicker2'
    format : 'DD-MM-YYYY'
  )

Template.update_vehicle.helpers
  'isCurrentState' : (state) ->
    return @status == state
  'myID' : ->
    Session.set 'theID', @locate
    return Session.get 'theID'
  'locations': ->
    Meteor.subscribe 'locations'
    buildSite = Session.get 'theID'
    {
    places : Locations.find()
    buildingSite : buildSite
    }
  'cates': ->
    Meteor.subscribe 'vehicle_category'
    return Vehicle_Category.find()

Template.update_vehicle.events
  'submit .vehicle-edit-form' : (event) ->
    event.preventDefault()
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    licencePlate        = event.target.licencePlate.value
    vin                 = event.target.vin.value
    engineNumber        = event.target.engineNumber.value
    description         = event.target.desc.value
    compStatus          = event.target.compStatus.value
    category            = event.target.category.value
    location            = event.target.location.value

    Meteor.call 'editVehicle' , @_id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, licencePlate, vin, engineNumber, category, location, description, compStatus
    Router.go 'vehicles'

Template.location_vehicle_option.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.locate
    return @siteName == buildSite

Template.vehicle_category_options.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.category
    return @_id == buildSite