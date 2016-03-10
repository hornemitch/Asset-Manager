Template.create_cellphone.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'cellphones'

Template.create_cellphone.onRendered ->
  Meteor.subscribe 'locations'
  Session.set 'hasContract', true

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

  $('.addCellphone').validate
    rules:
      costPrice:
        required: true
      supplier:
        required: true
      manufacturer:
        required: true
      model:
        required: true
      purchaseDate:
        required: true
      warrantyExpiration:
        required: true
      cellNumber:
        required: true
        cellNumber: true
      cellUser:
        required: true
      maxData:
        required: true
      pin:
        required: true
      puk:
        required: true
      sim:
        required: true
      desc:
        required: true
    messages:
      costPrice:
        required: "Please enter the mobile phone's purchase price"
      supplier:
        required: 'Please specify the supplier of the mobile phone'
      manufacturer:
        required: 'Please specify the manufacturer of the mobile phone'
      model:
        required: 'Please specify the model of the mobile phone'
      purchaseDate:
        required: 'Please choose the purchase date'
      warrantyExpiration:
        required: "Please choose the mobile phone's warranty expiration date"
      cellNumber:
        required: "Please enter the mobile phone's number"
        cellNumber: 'Please enter a valid 10 digit number'
      cellUser:
        required: "Please enter the mobile phone's user's name"
      maxData:
        required: "Please enter the mobile phone's maximum monthly data limit"
      pin:
        required: "Please enter the mobile phone's PIN number"
      puk:
        required: "Please enter the mobile phone's PUK number"
      sim:
        required: "Please enter the mobile phone's SIM number"
      desc:
        required: 'Please describe the mobile phone'

Template.create_cellphone.helpers
  'locations': ->
    return Locations.find()
  'hasContract': ->
    return Session.get 'hasContract'

Template.create_cellphone.events
  'submit .addCellphone': (event) ->
    event.preventDefault()
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    cellNumber          = event.target.cellNumber.value
    user                = event.target.cellUser.value
    contractStart       = event.target.contractStart.value
    contractEnd         = event.target.contractEnd.value
    location            = event.target.location.value
    pin                 = event.target.pin.value
    puk                 = event.target.puk.value
    sim                 = event.target.sim.value
    description         = event.target.desc.value
    createdBy           = Meteor.user().username

    if invoiceNumber == ''
      invoiceNumber = 'No Invoice'
    if purchaseOrderNumber == ''
      purchaseOrderNumber = 'No Purchase Order'
    contract = Session.get 'hasContract'

    if contract == true
      Meteor.call 'addCellphone', invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, cellNumber, user, contractStart, contractEnd, location, pin, puk, sim, description, createdBy
    else
      Meteor.call 'addCellphoneNoSub', invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, cellNumber, user, location, pin, puk, sim, description, createdBy
    Router.go 'cellphones'

  'click .contract': (event) ->
    event.preventDefault()
    Session.set 'hasContract', false
    document.getElementById('datepicker3').disabled = true
    document.getElementById('datepicker4').disabled = true

  'click .noContract': (event) ->
    event.preventDefault()
    Session.set 'hasContract', true
    document.getElementById('datepicker3').disabled = false
    document.getElementById('datepicker4').disabled = false