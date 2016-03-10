Template.update_cellphone.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'cellphones'

Template.update_cellphone.onRendered ->
  Meteor.subscribe 'cellphone', @_id

  if @data.contractEnd == null
    Session.set 'hasContract', false
  else
    Session.set 'hasContract', true

  picker = new Pikaday (
    field: document.getElementById 'datepicker'
    format : 'DD-MM-YYYY'
  )
  picker = new Pikaday (
    field: document.getElementById 'datepicker1'
    format : 'DD-MM-YYYY'
  )
  picker = new Pikaday (
    field: document.getElementById 'datepicker2'
    format : 'DD-MM-YYYY'
  )
  picker = new Pikaday (
    field: document.getElementById 'datepicker3'
    format : 'DD-MM-YYYY'
  )

  contractTrue = Session.get 'hasContract'

  if contractTrue == true
    document.getElementById('datepicker2').disabled = false
    document.getElementById('datepicker3').disabled = false
  else
    document.getElementById('datepicker2').disabled = true
    document.getElementById('datepicker3').disabled = true

  $('.cellphone-edit-form').validate
    rules:
      invoiceNumber:
          required: true
      purchaseOrderNumber:
          required: true
      costPrice:
        required: true
      purchaseDate:
        required: true
      model:
        required: true
      supplier:
        required: true
      manufacturer:
        required: true
      warrantyExpiration:
        required: true
      number:
        required: true
        cellNumber: true
      user:
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
      invoiceNumber:
        required: "Please enter the relevant invoice number"
      purchaseOrderNumber:
        required: "Please enter the relevant purchase order number"
      costPrice:
        required: "Please enter the mobile phone's purchase price"
      purchaseDate:
        required: 'Please choose the purchase date'
      model:
        required: 'Please specify the model of the mobile phone'
      supplier:
        required: 'Please specify the supplier of the mobile phone'
      manufacturer:
        required: 'Please specify the manufacturer of the mobile phone'
      warrantyExpiration:
        required: "Please choose the mobile phone's warranty expiration date"
      number:
        required: "Please enter the mobile phone's number"
        cellNumber: 'Please enter a valid 10 digit number'
      user:
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

Template.update_cellphone.helpers
  'isCurrentState' : (state) ->
    return @status == state
  'hasContract': ->
    return Session.get 'hasContract'
  'usefulLife': ->
    return 100/@depreciationRate

  'locations': ->
    Meteor.subscribe 'locations'
    buildSite = null
    {
    places : Locations.find()
    buildingSite : buildSite
    }

Template.update_cellphone.events
  'submit .cellphone-edit-form' : (event) ->
    event.preventDefault()
    status              = event.target.status.value
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    number              = event.target.number.value
    user                = event.target.user.value
    contractStart       = event.target.contractStart.value
    contractEnd         = event.target.contractEnd.value
    location            = event.target.locationSelect.value
    pin                 = event.target.pin.value
    puk                 = event.target.puk.value
    sim                 = event.target.sim.value
    description         = event.target.desc.value

    contract = Session.get 'hasContract'
    if contract == true

      Meteor.call 'editCellphone' , @_id, status, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, number, user, contractStart, contractEnd, location, pin, puk, sim, description

    else
      Meteor.call 'editNoSubCellphone' , @_id, status, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, number, user, location, pin, puk, sim, description
    Router.go 'cellphones'

  'click .contract': (event)->
    event.preventDefault()
    Session.set 'hasContract', false
    document.getElementById('datepicker2').disabled = true
    document.getElementById('datepicker3').disabled = true

  'click .noContract': (event)->
    event.preventDefault()
    Session.set 'hasContract', true
    document.getElementById('datepicker2').disabled = false
    document.getElementById('datepicker3').disabled = false

    date1 = document.getElementById 'datepicker2'
    date2 = document.getElementById 'datepicker3'

    if date1.value == '' && date2.value == ''
      today = moment().format 'DD-MM-YYYY'

      $('#datepicker2').val today
      $('#datepicker3').val today

Template.location_cellphone_option.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.location
    return @siteName == buildSite