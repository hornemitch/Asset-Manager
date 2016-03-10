Template.home.onCreated ->
  #$('.body-container').css('background-color','rgba(0,0,0,0)')
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'home'
  #mainDoc.addClass 'loading'
  #Session.set 'imagesLoaded', false

  ima1 = new Image
  img2 = new Image
  ima3 = new Image
  img4 = new Image
  ima5 = new Image
  img6 = new Image
  ima7 = new Image
  img8 = new Image
  ima9 = new Image
  img10 = new Image
  ima11 = new Image
  img12 = new Image
  ima13 = new Image
  img14 = new Image
  img15 = new Image
  img16 = new Image
  img17 = new Image

  ima1.src = 'Buildings.jpg'
  img2.src = 'BuildingLife.jpg'
  ima3.src = 'Category.jpg'
  img4.src = 'Cellphones.jpg'
  ima5.src = 'CellphoneLife.jpg'
  img6.src = 'Computers.jpg'
  ima7.src = 'ComputerLife.jpg'
  img8.src = 'Furniture.jpg'
  ima9.src = 'FurnitureLife.jpg'
  img10.src = 'Home.jpg'
  ima11.src = 'Locations.jpg'
  img12.src = 'Login.jpg'
  ima13.src = 'Machines.jpg'
  img14.src = 'Reports.jpg'
  img15.src = 'Tools.jpg'
  img16.src = 'Training.jpg'
  img17.src = 'Vehicles.jpg'


Template.home.helpers
  'userLoggedIn': ->
    if Meteor.userId() != null
      return true
  'isAdmin' : ->
    user = Meteor.user().username.src
    if user == 'Adminastrator'
      return true
    else return false
  'getUser'  : ->
    user = toTitleCase Meteor.user().username
    return user
  'imagesLoaded': ->
    return true
    ###srcs = [
      'Buildings.jpg',
      'BuildingLife.jpg',
      'Category.jpg',
      'Cellphones.jpg',
      'CellphoneLife.jpg',
      'Computers.jpg',
      'ComputerLife.jpg',
      'Furniture.jpg',
      'FurnitureLife.jpg',
      'Home.jpg',
      'Locations.jpg',
      'Login.jpg',
      'Machines.jpg',
      'Reports.jpg',
      'Tools.jpg',
      'Training.jpg',
      'Vehicles.jpg',
    ]
    loaded = new Array(srcs.length);
    Session.set 'imagesLoaded', loaded
    _.each srcs, (path, i) ->
      image = new Image()
      image.src = path
      image.onload =>
        loaded = Session.get 'imagesLoaded'
        loaded[i] = 1
        Session.set 'loaded', loaded
    return true

    # loaded = Session.get 'imagesLoaded'
    # allLoaded = _.every(loaded, val => val is 1)
    # if allLoaded == true
    #   mainDoc = $('html')
    #   mainDoc.removeClass()
    #   mainDoc.addClass 'home'
    #   $('.body-container').css('background-color','rgba(255,255,255,0.85)')
    #   Session.set 'imagesLoaded', true
    #   return true
    # else
    #   return false

###

Template.home.events
  'click .loginButton': (event)->
    Router.go 'login'

  'click .createUsefulLives ': ->
    Meteor.call 'startBuildingLife'
    Meteor.call 'startCellphoneLife'
    Meteor.call 'startComputerLife'
    Meteor.call 'startFurnitureLife'
    Meteor.call 'startSmallAssetsLife'
    Meteor.call 'startSoftwareLife'
    window.alert 'Creation of lives successful'