Template.tool_category_create.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'categories'

  $('.addToolCategory').validate
    rules:
      categoryName :
        required : true
      usefulLife :
        required : true

    messages:
      categoryName :
        required : "Please enter a tool category name"
      usefulLife :
        required : "Please enter the category's useful life"

Template.tool_category_create.events
  'submit .addToolCategory': (event)->
    event.preventDefault()

    name = event.target.categoryName.value
    life = event.target.usefulLife.value

    Meteor.call 'addToolCategory', name, life
    Router.go 'tool.category'

Template.update_tool_category.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'categories'

  $('.input-form').validate
    rules:
      categoryName :
        required : true
      usefulLife :
        required : true

    messages:
      categoryName :
        required : "Please enter a tool category name"
      usefulLife :
        required : "Please enter the category's useful life"

Template.update_tool_category.events
  'submit .input-form': (event)->
    event.preventDefault()

    id   = @_id
    name = event.target.categoryName.value
    life = event.target.usefulLife.value

    Meteor.call 'editToolCategory', id, name, life
    Router.go 'tool.category'