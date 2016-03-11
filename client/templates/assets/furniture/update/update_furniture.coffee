Template.update_furniture.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'furniture'

Template.update_furniture.onRendered ->
  Meteor.subscribe 'furn', @_id

  picker = new Pikaday (
    field: document.getElementById 'datepicker1'
    format : 'DD-MM-YYYY'
  )

  picker = new Pikaday (
    field: document.getElementById 'datepicker2'
    format : 'DD-MM-YYYY'
  )

  $('.furniture-edit-form').validate
    rules:
      invoiceNumber:
        required: true
      purchaseOrderNumber:
        required: true
      costPrice :
        required : true
      usefulLife:
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
      invoiceNumber:
        required: 'Please enter an invoice number'
      purchaseOrderNumber:
        required: 'Please enter a purchase order number'
      costPrice :
        required : "Please enter the furniture's purchase price"
      usefulLife:
        required: "Please enter the furniture's useful life"
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

Template.update_furniture.helpers
  'isCurrentState' : (state) ->
    return @status == state
  'myID' : ->
    Session.set 'theID', @locate
    return Session.get 'theID'
  'locations': ->
    Meteor.subscribe 'locations'
    furnitureSite = Session.get 'theID'
    {
    places : Locations.find()
    buildingSite : furnitureSite
    }

Template.update_furniture.events
  'submit .furniture-edit-form' : (event) ->
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
    furnUser            = event.target.furnUser.value
    compStatus          = event.target.compStatus.value
    locationSelect      = event.target.locationSelect.value
    description         = event.target.description.value

    Meteor.call 'editFurniture' , @_id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, office, furnUser, compStatus, locationSelect, description
    Router.go 'furniture'

Template.location_furniture_option.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    furnitureSite = parent.locate
    return @siteName == furnitureSite