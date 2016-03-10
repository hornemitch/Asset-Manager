Template.vehicle_category_create.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'categories'

  $('.addMachineCategory').validate
    rules:
      categoryName :
        required : true
      usefulLife :
        required : true

    messages:
      categoryName :
        required : "Please enter a machine category name"
      usefulLife :
        required : "Please enter the category's useful life"

Template.vehicle_category_create.events
  'submit .add-vehicle-category': (event)->
    event.preventDefault()

    name = event.target.categoryName.value
    life = event.target.usefulLife.value

    Meteor.call 'addVehicleCategory', name, life
    Router.go 'vehicle.category'

Template.update_vehicle_category.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'categories'

  $('.vehicle-category-edit-form').validate
    rules:
      categoryName :
        required : true
      usefulLife :
        required : true

    messages:
      categoryName :
        required : "Please enter a vehicle category name"
      usefulLife :
        required : "Please enter the category's useful life"

Template.update_vehicle_category.events
  'submit .input-form': (event)->
    event.preventDefault()

    id   = @_id
    name = event.target.categoryName.value
    life = event.target.usefulLife.value

    Meteor.call 'editVehicleCategory', id, name, life
    Router.go 'vehicle.category'