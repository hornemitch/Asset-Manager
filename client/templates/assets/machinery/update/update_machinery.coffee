Template.update_machinery.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'machinery'

Template.update_machinery.onRendered ->
  picker = new Pikaday (
    field: document.getElementById 'datepicker1'
    format : 'DD-MM-YYYY'
  )

  picker = new Pikaday (
    field: document.getElementById 'datepicker2'
    format : 'DD-MM-YYYY'
  )

Template.update_machinery.helpers
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
    Meteor.subscribe 'machine_category'
    return Machine_Category.find()

Template.update_machinery.events
  'submit .machine-edit-form' : (event) ->
    event.preventDefault()
    invoiceNumber       = event.target.invoiceNumber.value
    purchaseOrderNumber = event.target.purchaseOrderNumber.value
    costPrice           = event.target.costPrice.value
    purchaseDate        = event.target.purchaseDate.value
    model               = event.target.model.value
    serialNumber        = event.target.serialNumber.value
    warrantyExpiration  = event.target.warrantyExpiration.value
    category            = event.target.category.value
    supplier            = event.target.supplier.value
    manufacturer        = event.target.manufacturer.value
    compUser            = event.target.compUser.value
    compStatus          = event.target.compStatus.value
    description         = event.target.description.value
    location            = event.target.location.value

    Meteor.call 'editMachine' , @_id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, serialNumber, warrantyExpiration, supplier, manufacturer, compUser, compStatus, description, category, location
    Router.go 'machinery'

  'click .cancelButton': (event) ->
    event.preventDefault()
    Router.go 'machinery'

Template.location_machinery_option.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.locate
    return @siteName == buildSite

Template.machine_category_options.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.category
    return @_id == buildSite