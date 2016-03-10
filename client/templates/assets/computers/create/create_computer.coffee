Template.update_computer.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computers'


Template.create_computer.onRendered ->
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

  $('.addComputer').validate
    rules:
      costPrice:
        required: true
      supplier:
        required: true
      manufacturer:
        required: true
      model:
        required: true
      serialNumber:
        required: true
      compUser:
        required: true
      purchaseDate:
        required: true
      warrantyExpiration:
        required: true
      desc:
        required: true

    messages:
      costPrice:
        required: "Please enter the computer's purchase price"
      supplier:
        required: "Please enter the supplier's name"
      manufacturer:
        required: "Please enter the manufacturer's name"
      model:
        required: "Please enter the model's name"
      serialNumber:
        required: "Please enter the computer's serial number"
      compUser:
        required: "Please enter the computer's user's name"
      purchaseDate:
        required: "Please choose the computer's purchase date"
      warrantyExpiration:
        required: "Please choose the computer's warranty expiration date"
      desc:
        required: "Please describe the computer"

Template.create_computer.helpers
  'locations': ->
    return Locations.find()

Template.create_computer.events
  'submit .addComputer': (event) ->
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
    user                = event.target.compUser.value
    locate              = event.target.location.value
    description         = event.target.desc.value
    createdBy           = Meteor.user().username

    if invoiceNumber == ''
      invoiceNumber = 'No Invoice'
    if purchaseOrderNumber == ''
      purchaseOrderNumber = 'No Purchae Order'

    Meteor.call 'addComputer', invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, serialNumber, user, locate, description, createdBy
    Router.go 'computers'