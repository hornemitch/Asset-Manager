Template.create_vehicle.onRendered ->
  picker = new Pikaday (
    field: document.getElementById 'datepicker1'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker1').val today

  picker = new Pikaday (
    field: document.getElementById 'datepicker2'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker2').val today

  $('.addVehicle').validate
    rules:
      purchaseDate :
        required : true
      costPrice :
        required : true
      supplier :
        required : true
      manufacturer :
        required : true
      model :
        required : true
      licencePlate :
        required : true
      vin :
        required : true
      engineNumber :
        required : true
      warrantyExpiration :
        required : true
      odometer :
        required : true
      desc :
        required : true

    messages:
      purchaseDate :
        required : "Please choose the vehicle's purchase date"
      costPrice :
        required : "Please enter the vehicle's purchase price"
      supplier :
        required : "Please enter the vehicle's supplier name"
      manufacturer :
        required : "Please enter the vehicle's manufacturer name"
      model :
        required : "Please enter the vehicle's model name"
      licencePlate :
        required : "Please enter the vehicle's licence plate number"
      vin :
        required : "Please enter the vehicle identification number"
      engineNumber :
        required : "Please enter the vehicles engine number"
      warrantyExpiration :
        required : "Please choose the vehicle's warranty expiration date"
      odometer :
        required : "Please enter the current vehicle odometer reading"
      desc :
        required : "Please describe the vehicle"

Template.create_vehicle.helpers
  'categories': ->
    Meteor.subscribe 'vehicle_category'
    return Vehicle_Category.find()
  'locations': ->
    Meteor.subscribe 'locations'
    return Locations.find()

Template.create_vehicle.events
  'submit .addVehicle': (event) ->
    event.preventDefault()
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    invoiceScan         = Session.get 'invoiceImageID'
    assetPicture        = Session.get 'assetImageID'
    licencePlate        = event.target.licencePlate.value
    vin                 = event.target.vin.value
    engineNumber        = event.target.engineNumber.value
    odometer            = event.target.odometer.value
    category            = event.target.category.value
    location            = event.target.location.value
    description         = event.target.desc.value
    createdBy           = Meteor.user().username

    Meteor.call "addVehicle", invoiceNumber, purchaseOrderNumber, costPrice,purchaseDate, model, supplier, manufacturer, warrantyExpiration, licencePlate, vin, engineNumber, odometer, category, location, description, createdBy
    Router.go 'vehicles'