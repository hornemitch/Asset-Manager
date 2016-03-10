Template.computer_software.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computers'

Template.computer_software.helpers
  'selector': ->
    id = @_id
    return { computerId: id }

Template.computer_software.events
  'click .removeButton': (event) ->
    event.preventDefault()
    conf = window.confirm('Deleting this Software will permanently delete all its data')
    if conf == true
      Meteor.call 'deleteSoftware', @_id

Template.computer_software_detail.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computers'

Template.computer_software_detail.helpers
  'decDep': ->
    return parseFloat(Math.round(@depreciation * 100) / 100).toFixed(2)

  'showValue': (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

  'installed': ->
    if @installed == true
      return 'Is installed'
    else
      return 'Is not installed'

  'location': ->
    Meteor.subscribe 'computer', @computerId
    computer = Computers.findOne @computerId
    return computer.locate

  'bookValue': ->
    buyDate  = @acquiredDate
    split    = buyDate.split('-')

    oldmonth = split[1]
    oldYear  = split[2]

    nowdate       = new Date()
    newMonth      = nowdate.getMonth() + 1
    newYear       = nowdate.getFullYear()

    months = (newYear - oldYear)*12 + (newMonth - oldmonth)
    totalDepreciation =(@purchaseCost * (@depreciation/100/12 * months))
    bookValue= @purchaseCost - totalDepreciation
    bookValue= parseFloat(bookValue).toFixed(2)
    return bookValue

Template.computer_software_detail.events
  'click .backButton': (event) ->
    event.preventDefault()
    Router.go 'computer.software', _id:@computerId

Template.computer_software_create.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computers'

Template.computer_software_create.onRendered ->
  Session.set 'installed', true

  picker = new Pikaday (
    field: document.getElementById 'date1'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#date1').val today

  picker = new Pikaday (
      field: document.getElementById 'date2'
      format : 'DD-MM-YYYY'
    )
  today = moment().format 'DD-MM-YYYY'
  $('#date2').val today

  $('.computer-software-form').validate
    rules:
      name:
        required: true
      purchaseCost:
        required: true
      acquiredDate:
        required: true
      licenceRenewalDate:
        required: true
      supplier:
        required: true
      developer:
        required: true
      licenceKey:
        required: true

    messages:
      name:
        required: "Please enter the software's name"
      purchaseCost:
        required: "Please enter the software's purchase price"
      acquiredDate:
        required: "Please choose the software's purchase date"
      licenceRenewalDate:
        required: "Please choose the software's licence renewal date"
      supplier:
        required: "Please enter the supplier's name"
      developer:
        required: "Please enter the software's developer's name"
      licenceKey:
        required: "Please enter the software's licence key"

Template.computer_software_create.helpers
  'isInstalled': ->
    return Session.get 'installed'

Template.computer_software_create.events
  'submit .computer-software-form' : (event) ->
    event.preventDefault()

    installed          = Session.get 'installed'
    name               = event.target.name.value
    licenceKey         = event.target.licenceKey.value
    licenceRenewalDate = event.target.licenceRenewalDate.value
    purchaseCost       = event.target.purchaseCost.value
    acquiredDate       = event.target.acquiredDate.value
    supplier           = event.target.supplier.value
    developer          = event.target.developer.value
    invoiceNumber      = event.target.invoiceNumber.value
    purchaseOrder      = event.target.purchaseOrder.value
    description        = event.target.description.value

    if invoiceNumber == ''
      invoiceNumber = 'No Invoice'
    if purchaseOrder == ''
      purchaseOrder = 'No Purchase Order'

    Meteor.call 'addSoftware', @_id, name, installed, licenceKey, licenceRenewalDate, purchaseCost, acquiredDate, supplier, developer, invoiceNumber, purchaseOrder, description
    Router.go 'computer.software', _id:@_id

  'click .notInstalled': ->
    Session.set 'installed', false
    document.activeElement.blur()
  'click .installed': ->
    Session.set 'installed', true
    document.activeElement.blur()

Template.computer_software_update.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'computers'

Template.computer_software_update.onRendered ->
  if @.data.installed == true
    Session.set 'installed', true
  else
    Session.set 'installed', false

  picker = new Pikaday (
    field: document.getElementById 'date1'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#date1').val today

  picker = new Pikaday (
    field: document.getElementById 'date2'
    format : 'DD-MM-YYYY'
  )
  today = moment().format 'DD-MM-YYYY'
  $('#date2').val today

  $('.computer-software-form').validate
    rules:
      name:
        required: true
      purchaseCost:
        required: true
      acquiredDate:
        required: true
      licenceRenewalDate:
        required: true
      supplier:
        required: true
      developer:
        required: true
      licenceKey:
        required: true

    messages:
      name:
        required: "Please enter the software's name"
      purchaseCost:
        required: "Please enter the software's purchase price"
      acquiredDate:
        required: "Please choose the software's purchase date"
      licenceRenewalDate:
        required: "Please choose the software's licence renewal date"
      supplier:
        required: "Please enter the supplier's name"
      developer:
        required: "Please enter the software's developer's name"
      licenceKey:
        required: "Please enter the software's licence key"

Template.computer_software_update.helpers
  'isCurrentState' : (state) ->
    return @status == state

  'usefulLife': ->
    return 100/@depreciation

  'isInstalled': ->
    return Session.get 'installed'

Template.computer_software_update.events
  'submit .computer-software-form' : (event) ->
    event.preventDefault()

    installed          = Session.get 'installed'
    status             = event.target.usefulLife.value
    usefulLife         = event.target.status.value
    name               = event.target.name.value
    licenceKey         = event.target.licenceKey.value
    licenceRenewalDate = event.target.licenceRenewalDate.value
    purchaseCost       = event.target.purchaseCost.value
    acquiredDate       = event.target.acquiredDate.value
    supplier           = event.target.supplier.value
    developer          = event.target.developer.value
    invoiceNumber      = event.target.invoiceNumber.value
    purchaseOrder      = event.target.purchaseOrder.value
    description        = event.target.description.value

    Meteor.call 'editSoftware', @_id, status, usefulLife, name, installed, licenceKey, licenceRenewalDate, purchaseCost, acquiredDate, supplier, developer, invoiceNumber, purchaseOrder, description
    Router.go 'computer.software', _id:@computerId

  'click .notInstalled': ->
    Session.set 'installed', false
    document.activeElement.blur()
  'click .installed': ->
    Session.set 'installed', true
    document.activeElement.blur()

  'click .backButton': (event) ->
    event.preventDefault()
    Router.go 'computer.software', _id:@computerId

Template.computer_software_useful_life.onRendered ->
  $('.input-form').validate
    rules:
      lifeValue:
        required: true
    messages:
      lifeValue:
        required: 'Please enter the new useful life'

Template.computer_software_useful_life.helpers
  'depcap': ->
    depreciation = @depreciation.toFixed(2)
    return depreciation

Template.computer_software_useful_life.events
  'click .backButton': (event) ->
    event.preventDefault()
    Router.go 'computers'

  'submit .useful-life-form': (event)->
    event.preventDefault()

    life = event.target.lifeValue.value

    Meteor.call 'updateSoftwareLife', life
    Router.go 'computers'