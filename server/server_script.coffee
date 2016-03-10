###
  * * * * * * * * * * * * * * *
    Meteor Publish Statements
  * * * * * * * * * * * * * * *
###

# * * Building Publish Statements * * #
Meteor.publish 'buildings', ->
  Buildings.find()
Meteor.publish 'building', (id)->
  Buildings.find(id)

# * * Cellphone Publish Statements * * #
Meteor.publish 'cellphones', ->
  Cellphones.find()
Meteor.publish 'cellphone', (id)->
  Cellphones.find(id)
Meteor.publish 'cellphone_monthly', ->
  Cellphone_Monthly.find()

# * * Computer Publish Statements * * #
Meteor.publish 'companies', ->
  Companies.find()
Meteor.publish 'computers', ->
  Computers.find()
Meteor.publish 'computer', (id) ->
  Computers.find(id)
Meteor.publish 'computer_software', (id) ->
  Computer_Software.find(id)

# * * Furniture Publish Statements * * #
Meteor.publish 'furniture', ->
  Furniture.find()
Meteor.publish 'furn', (id) ->
  Furniture.find(id)

# * * Location Publish Statements * * #
Meteor.publish 'locations', ->
  Locations.find()

# * * Machinery Publish Statements * * #
Meteor.publish 'machinery', ->
  Machinery.find()
Meteor.publish 'machine', (id) ->
  Machinery.find(id)
Meteor.publish 'machine_category', ->
  Machine_Category.find()

# * * Tool Publish Statements * * #
Meteor.publish 'tools', ->
  Tools.find()
Meteor.publish 'tool', (id) ->
  Tools.find(id)
Meteor.publish 'tool_category', ->
  Tool_Category.find()

# * * Vehicle Publish Statements * * #
Meteor.publish 'vehicles', ->
  Vehicles.find()
Meteor.publish 'vehicle', (id) ->
  Vehicles.find(id)
Meteor.publish 'vehicle_category', ->
  Vehicle_Category.find()

# * * User Publish Statements * * #
Meteor.publish 'users', ->
  Meteor.users.find()

# * * Useful Life Publish Statements * * #
Meteor.publish 'usefulLife', ->
  UsefulLife.find()

###
  * * * * * * * * * * * * * * * * *
    Meteor Accounts Configuration
  * * * * * * * * * * * * * * * * *
###

# * * Prevent Client-Side Account Creation * * #
Accounts.config
  forbidClientAccountCreation : true

# * * Prevent User Login After Creation of User * * #
Accounts.validateLoginAttempt (attemptInfo) ->
  today = new Date()
  if attemptInfo.methodName == 'createUser'
    return false
  else
    return true

# * * Get Date Function * * #
@getToday = ->
  today = new Date()
  dd = today.getDate()
  mm = today.getMonth()+1
  yyyy = today.getFullYear()

  if(dd<10)
    dd='0'+dd
  if(mm<10)
    mm='0'+mm
  today = mm+'-'+dd+'-'+yyyy;

###
  * * * * * * * * * * * * * *
    General Meteor Methods
  * * * * * * * * * * * * * *
###

Meteor.methods
# * * Method for Generation of Asset Numbers * * #
  'removeLetters': (string) ->
    newString = string.replace(/\D/g, "")
    return newString

# * * Method to Change User Password * * #
  'changeMyPassword':(userID, newPassword) ->
      Accounts.setPassword userID, newPassword

# * * Console Method for Creation of Admin * * #
  'createAdmin': ->
    Accounts.createUser
      username    : 'Adminastrator'
      password    : 'Boondocks5'

# * * Method for User Creation * * #
  'addUser': (admin, adminPass, userName, password, company, today, yearFromNow) ->
    if admin == 'Adminastrator' && adminPass == 'Boondocks5'

      Accounts.createUser
        username    : userName
        password    : password
        company     : company
        CreatedDate : today
        ExpiryDate  : yearFromNow

# * * Method for Creation of User Company* * #
  'addCompany': (company) ->
    Companies.insert
      coName : company

# * * Method for Creation of a Location * * #
  'addLocation': (siteName, addressCountry, addressProvince, addressCity, addressPostalCode, addressStreetAndNumber) ->
    if Locations.find().count() != 0
      lastLocation = Locations.findOne {}, sort: createdDate : -1
      number = Meteor.call "removeLetters", lastLocation.locationNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = "LOCA" + newNumber
    date = new Date()

    Locations.insert
      locationNumber  : aNum
      siteName        : siteName
      country         : addressCountry
      province        : addressProvince
      city            : addressCity
      postalCode      : addressPostalCode
      streetAndNumber : addressStreetAndNumber
      createdDate     : date

# * * Method to Delete Location(Only Console Now) * * #
  'deleteLocation' : (locationId) ->
    Locations.remove locationId