Template.machine_category.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'categories'

Template.machine_category_create.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'categories'

Template.machine_category_create.onRendered ->
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

Template.machine_category_create.events
  'submit .addMachineCategory': (event)->
    event.preventDefault()

    name = event.target.categoryName.value
    life = event.target.usefulLife.value

    Meteor.call 'addMachineCategory', name, life
    Router.go 'machine.category'

Template.update_machine_category.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'categories'

Template.update_machine_category.onRendered ->
  $('.machine-category-edit-form').validate
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

Template.update_machine_category.events
  'submit .machine-category-edit-form': (event)->
    event.preventDefault()

    id   = @_id
    name = event.target.categoryName.value
    life = event.target.usefulLife.value

    Meteor.call 'editMachineCategory', id, name, life
    Router.go 'machine.category'