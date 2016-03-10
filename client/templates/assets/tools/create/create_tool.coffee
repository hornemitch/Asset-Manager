Template.create_tool.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'tools'

Template.create_tool.onRendered ->
  Session.set 'calib', true

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

  picker = new Pikaday (
    field: document.getElementById 'datepicker3'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker3').val today

  picker = new Pikaday (
    field: document.getElementById 'datepicker4'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#datepicker4').val today

  $('.addTool').validate
    rules:
      costPrice :
        required : true
      supplier :
        required : true
      manufacturer :
        required : true
      model :
        required : true
      serial :
        required : true
      purchaseDate :
        required : true
      warrantyExpiration :
        required : true
      certNumber :
        required : true
      calibrationDate :
        required : true
      renewalDate :
        required : true

    messages:
      costPrice :
        required : "Please enter the tool's purchase price"
      supplier :
        required : "Please enter the supplier's name"
      manufacturer :
        required : "Please enter the manufacturer's name"
      model :
        required : "Please enter the model's name"
      serial :
        required : "Please enter the tool's serial number"
      purchaseDate :
        required : "Please choose a purchase date"
      warrantyExpiration :
        required : "Please choose a warranty expiration date"
      certNumber :
        required : "Please enter the tool's certification number"
      calibrationDate :
        required : "Please choose the tool's calibration date"
      renewalDate :
        required : "Please choose the tool's recalibration date"

Template.create_tool.helpers
  'categories': ->
    Meteor.subscribe 'tool_category'
    return Tool_Category.find()
  'locations': ->
    Meteor.subscribe 'locations'
    return Locations.find()
  'calibrationNeeded': ->
    return Session.get 'calib'

Template.create_tool.events
  'submit .addTool': (event) ->
    event.preventDefault()
    calibration = Session.get 'calib'

    if calibration
      invoiceNumber       = event.target.invoiceNumber.value
      purchaseOrderNumber = event.target.purchaseOrderNumber.value
      costPrice           = event.target.costPrice.value
      purchaseDate        = event.target.purchaseDate.value
      model               = event.target.model.value
      supplier            = event.target.supplier.value
      manufacturer        = event.target.manufacturer.value
      warrantyExpiration  = event.target.warrantyExpiration.value
      serial              = event.target.serial.value
      certificationNumber = event.target.certNumber.value
      calibrationDate     = event.target.calibrationDate.value
      renewalDate         = event.target.renewalDate.value
      locate              = event.target.location.value
      category            = event.target.category.value
      description         = event.target.description.value
      createdBy           = Meteor.user().username
    else
      invoiceNumber       = event.target.invoiceNumber.value
      purchaseOrderNumber = event.target.purchaseOrderNumber.value
      costPrice           = event.target.costPrice.value
      purchaseDate        = event.target.purchaseDate.value
      model               = event.target.model.value
      supplier            = event.target.supplier.value
      manufacturer        = event.target.manufacturer.value
      warrantyExpiration  = event.target.warrantyExpiration.value
      serial              = event.target.serial.value
      certificationNumber = null
      calibrationDate     = null
      renewalDate         = null
      locate              = event.target.location.value
      category            = event.target.category.value
      description         = event.target.description.value
      createdBy           = Meteor.user().username

    if invoiceNumber == ''
      invoiceNumber = 'No Invoice'
    if purchaseOrderNumber == ''
      purchaseOrderNumber = 'No Purchase Order'

    Meteor.call "addTool", invoiceNumber, purchaseOrderNumber, costPrice,purchaseDate, model, supplier, manufacturer, warrantyExpiration, serial, certificationNumber, calibrationDate, renewalDate,  locate, category, description, createdBy
    Router.go 'tools'

  'click .noCalibButton': (event)->
    event.preventDefault()
    document.getElementById('calibInputs1').disabled = true
    document.getElementById('datepicker3').disabled = true
    document.getElementById('datepicker4').disabled = true
    Session.set 'calib', false

  'click .CalibButton': (event)->
    event.preventDefault()
    document.getElementById('calibInputs1').disabled = false
    document.getElementById('datepicker3').disabled = false
    document.getElementById('datepicker4').disabled = false
    Session.set 'calib', true