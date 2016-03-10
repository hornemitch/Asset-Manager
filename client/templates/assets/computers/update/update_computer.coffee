Template.update_computer.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computers'

Template.update_computer.onRendered ->
  Meteor.subscribe 'computer', @_id

  picker = new Pikaday (
    field: document.getElementById 'datepicker1'
    format : 'DD-MM-YYYY'
  )

  picker = new Pikaday (
    field: document.getElementById 'datepicker2'
    format : 'DD-MM-YYYY'
  )

  $('..computer-edit-form').validate
    rules:
      invoiceNumber:
        required: true
      purchaseOrderNumber:
        required: true
      costPrice:
        required: true
      usefulLife:
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
      invoiceNumber:
        required: "Please enter the relevant invoice number"
      purchaseOrderNumber:
        required: "Please enter the relevant purchase order number"
      costPrice:
        required: "Please enter the computer's purchase price"
      usefulLife:
        required: "Please enter the computer's useful life"
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

Template.update_computer.helpers
  'isCurrentState' : (state) ->
    return @status == state

  'locations': ->
    Meteor.subscribe 'locations'
    buildSite = null
    {
    places : Locations.find()
    buildingSite : buildSite
    }

  'usefulLife': ->
    return 100/@depreciationRate

Template.update_computer.events
  'submit .computer-edit-form' : (event) ->
    event.preventDefault()
    usefulLife          = event.target.usefulLife.value
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    serialNumber        = event.target.serialNumber.value
    compUser            = event.target.compUser.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    compStatus          = event.target.compStatus.value
    description         = event.target.desc.value
    locate              = event.target.locationSelect.value

    Meteor.call 'editComputer' , @_id, usefulLife, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, warrantyExpiration, serialNumber, compUser, supplier, manufacturer, locate, compStatus, description
    Router.go 'computers'

Template.location_computer_option.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.locate
    return @siteName == buildSite