Template.create_machinery.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'machinery'

Template.create_machinery.onRendered ->
  Meteor.subscribe 'locations'
  Meteor.subscribe 'machine_category'

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

  $('.addMachine').validate
    rules:
      costPrice :
        required : true
      supplier :
        required : true
      manufacturer :
        required : true
      model :
        required : true
      serialNumber :
        required : true
      machUser :
        required : true
      purchaseDate :
        required : true
      warrantyExpiration :
        required : true
      description :
        required : true

    messages:
      costPrice :
        required : "Please enter the machine's purchase price"
      supplier :
        required : "Please enter the supplier's name"
      manufacturer :
        required : "Please enter the manufacturer's name"
      model :
        required : "Please enter the model's name"
      serialNumber :
        required : "Please enter the machine's serial number"
      machUser :
        required : "Please enter the machine's user's name"
      purchaseDate :
        required : "Please choose a purchase date"
      warrantyExpiration :
        required : "Please choose a warranty expiration date"
      description :
        required : 'Please describe the machine'

Template.create_machinery.helpers
  'categories': ->
    return Machine_Category.find()
  'locations': ->
    return Locations.find()

Template.create_machinery.events
  'submit .addMachine': (event) ->
    event.preventDefault()
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    serialNumber        = event.target.serialNumber.value
    user                = event.target.machUser.value
    description         = event.target.description.value
    locate              = event.target.location.value
    category            = event.target.category.value
    createdBy           = Meteor.user().username

    if invoiceNumber == ''
      invoiceNumber = 'no Invoice'
    if purchaseOrderNumber == ''
      purchaseOrderNumber = 'no Purchase Order'

    Meteor.call 'addMachine', invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, serialNumber, user, description, locate, category, createdBy
    Router.go 'machinery'