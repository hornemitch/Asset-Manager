Template.tool.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'tools'

Template.tool.helpers
  'tools': ->
    return Tools.find()
  'locations': ->
    return Locations.find()
  'addToolTemplate': ->
    return Session.get "addToolTemplate"
  'hasLocations': ->
    Meteor.subscribe 'locations'
    hasloc = Locations.find()
    if hasloc.count() == 0
      return false
    else
      return true
  'hasCategory': ->
    Meteor.subscribe 'tool_category'
    cate = Tool_Category.find()
    if cate.count() == 0
      return false
    else
      return true

Template.tool.events
  "click .removeButton": ->
    conf = window.confirm('Deleting this tool will permanently delete all of its data')
    if conf == true
      Meteor.call "deleteTool", @_id

  "click .addingButton": ->
    Router.go 'tool.create'

  'click .addCategoryButton': ->
    Router.go 'tool.category'