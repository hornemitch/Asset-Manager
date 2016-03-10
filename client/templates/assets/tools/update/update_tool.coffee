Template.update_tool.onRendered ->
  if @.data.certificationNumber == null
    Session.set 'calib', false
    document.getElementById('calibInputs1').disabled = true
    document.getElementById('datepicker3').disabled = true
    document.getElementById('datepicker4').disabled = true
  else
    Session.set 'calib', true

  today = new Date()
  dd = today.getDate()
  mm = today.getMonth()+1
  yyyy = today.getFullYear()

  if(dd<10)
    dd='0'+dd
  if(mm<10)
    mm='0'+mm
  today = mm+'-'+dd+'-'+yyyy;
  Session.set 'today', today

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
  picker = new Pikaday (
    field: document.getElementById 'datepicker4'
    format : 'DD-MM-YYYY'
  )

  $('.tool-edit-form').validate
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

Template.update_tool.helpers
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

  'calibrationNeeded': ->
    return Session.get 'calib'

  'cates': ->
    Meteor.subscribe 'tool_category'
    return Tool_Category.find()

Template.update_tool.events
  'submit .tool-edit-form' : (event) ->
    event.preventDefault()
    cal = Session.get 'calib'
    if cal == true
      invoiceNumber       = event.target.invoiceNumber.value
      purchaseOrderNumber = event.target.purchaseOrderNumber.value
      costPrice           = event.target.costPrice.value
      purchaseDate        = event.target.purchaseDate.value
      model               = event.target.model.value
      supplier            = event.target.supplier.value
      manufacturer        = event.target.manufacturer.value
      warrantyExpiration  = event.target.warrantyExpiration.value
      serial              = event.target.serial.value
      status              = event.target.status.value
      categorySelect      = event.target.categorySelect.value
      locationSelect      = event.target.locationSelect.value
      certificationNumber = event.target.certNumber.value
      calibrationDate     = event.target.calibrationDate.value
      renewalDate         = event.target.renewalDate.value
      description         = event.target.description.value
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
      status              = event.target.status.value
      categorySelect      = event.target.categorySelect.value
      locationSelect      = event.target.locationSelect.value
      certificationNumber = null
      calibrationDate     = null
      renewalDate         = null
      description         = event.target.description.value

    Meteor.call 'editTool' , @_id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, serial, status, categorySelect, locationSelect, certificationNumber ,calibrationDate ,renewalDate, description
    Router.go 'tools'

  'click .noCalibButton': (event)->
    event.preventDefault()
    document.getElementById('calibInputs1').disabled = true
    document.getElementById('datepicker3').disabled = true
    document.getElementById('datepicker4').disabled = true
    Session.set 'calib', false

  'click .CalibButton': (event)->
    event.preventDefault()
    today = Session.get 'today'

    document.getElementById('calibInputs1').disabled = false
    document.getElementById('datepicker3').disabled = false
    if @certificationNumber == null
      document.getElementById('datepicker3').value = today
    else
      document.getElementById('datepicker3').value = @calibrationDate
    document.getElementById('datepicker4').disabled = false
    if @certificationNumber == null
      document.getElementById('datepicker4').value = today
    else
      document.getElementById('datepicker4').value = @renewalDate

    Session.set 'calib', true

Template.location_tool_option.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.locate
    return @siteName == buildSite

Template.tool_category_options.helpers
  'isSelected': ->
    parent = Template.parentData(1)
    buildSite = parent.category
    return @_id == buildSite