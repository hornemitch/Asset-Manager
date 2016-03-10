Template.create_furniture.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'furniture'

Template.create_furniture.onRendered ->
  Meteor.subscribe 'locations'

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

  $('.addFurniture').validate
    rules:
      costPrice :
        required : true
      supplier :
        required : true
      manufacturer :
        required : true
      model :
        required : true
      purchaseDate :
        required : true
      warrantyExpiration :
        required : true
      office :
        required : true
      furnUser :
        required : true
      description :
        required : true

    messages:
      costPrice :
        required : "Please enter the furniture's purchase price"
      supplier :
        required : "Please enter the supplier's name"
      manufacturer :
        required : "Please enter the manufacturer's name"
      model :
        required : "Please enter the model's name"
      purchaseDate :
        required : 'Please choose a purchase date'
      warrantyExpiration :
        required : 'Please choose a warranty expiration date'
      office :
        required : "Please enter the furniture's office's name or number"
      furnUser :
        required : "Please enter the furniture's user's name"
      description :
        required : 'Please describe the furniture'

Template.create_furniture.helpers
  'locations': ->
    return Locations.find()

Template.create_furniture.events
  'submit .addFurniture': (event) ->
    event.preventDefault()
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    office              = event.target.office.value
    user                = event.target.furnUser.value
    description         = event.target.description.value
    locate              = event.target.location.value
    createdBy           = Meteor.user().username

    if invoiceNumber == '' || invoiceNumber == null
      invoiceNumber = 'No Invoice'
    if purchaseOrderNumber == '' || purchaseOrderNumber == null
      purchaseOrderNumber = 'No Purchase Order'

    Meteor.call 'addFurniture', invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, office, user, description, locate,createdBy
    Router.go 'furniture'