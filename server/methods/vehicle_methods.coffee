getToday = ->
  today = new Date()
  dd = today.getDate()
  mm = today.getMonth()+1
  yyyy = today.getFullYear()

  if(dd<10)
    dd='0'+dd
  if(mm<10)
    mm='0'+mm
  today = mm+'-'+dd+'-'+yyyy;

Meteor.methods
  'addVehicle':(invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, licencePlate, vin, engineNumber, odometer, category, location, description, createdBy) ->
    if Vehicles.find().count() != 0
      lastVehicle = Vehicles.findOne {}, sort: checkDate : -1
      number = Meteor.call "removeLetters", lastVehicle.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = "MV" + newNumber
    checkDate = new Date()
    date = getToday()

    Vehicles.insert
      assetNumber         : aNum
      invoiceNumber       : invoiceNumber
      purchaseOrderNumber : purchaseOrderNumber
      costPrice           : costPrice
      purchaseDate        : purchaseDate
      model               : model
      supplier            : supplier
      manufacturer        : manufacturer
      warrantyExpiration  : warrantyExpiration
      licencePlate        : licencePlate
      VIN                 : vin
      engineNumber        : engineNumber
      odometerCurrent     : odometer
      category            : category
      location            : location
      description         : description
      createdBy           : createdBy
      createdDate         : date
      checkDate           : checkDate

  'editVehicle':(id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, licencePlate, vin, engineNumber, category, location, description, compStatus) ->

    Vehicles.update id ,
      $set :
        invoiceNumber       : invoiceNumber
        purchaseOrderNumber : purchaseOrderNumber
        costPrice           : costPrice
        purchaseDate        : purchaseDate
        model               : model
        supplier            : supplier
        manufacturer        : manufacturer
        warrantyExpiration  : warrantyExpiration
        licencePlate        : licencePlate
        VIN                 : vin
        engineNumber        : engineNumber
        status              : compStatus
        category            : category
        location            : location
        description         : description

  'addVehicleCategory' : (name, life)->
    depreciation = 100/life

    Vehicle_Category.insert
      name         : name
      usefulLife   : life
      depreciation : depreciation

  'editVehicleCategory' : (id, name, life)->
    depreciation = 100/life

    Vehicle_Category.update id,
      $set :
        name         : name
        usefulLife   : life
        depreciation : depreciation

  'addVehicleDaily':(id, currentOdometer, date, odometerReading, comment) ->

    distanceTraveled = odometerReading - currentOdometer

    Vehicle_Daily.insert
      vehicleId        : id
      date             : date
      currentOdometer  : currentOdometer
      odometerReading  : odometerReading
      distanceTraveled : distanceTraveled
      comment          : comment

    Vehicles.update id,
      $set :
        odometerCurrent : odometerReading

  'setVehicleLoststolen':(id, lostStolenDate) ->
    Vehicles.update id,
      $set :
        isLostStolen   : true
        lostStolenDate : lostStolenDate

  'setVehicleScrapped':(id, scrappedTo, scrappedDate) ->
    Vehicles.update id,
      $set :
        isScrapped   : true
        scrappedTo   : scrappedTo
        scrappedDate : scrappedDate

  'setVehicleSold':(id, dateSold, SoldTo, sellPrice) ->
    thisVehicle = Vehicles.find id
    profitLoss  = thisVehicle.costPrice - sellPrice

    Vehicles.update id,
      $set :
        isSold     : true
        dateSold   : dateSold
        SoldTo     : SoldTo
        sellPrice  : sellPrice
        profitLoss : profitLoss

  'deleteVehicle' :(vehicleId) ->
    Vehicles.remove vehicleId
    Vehicle_Daily.remove {vehicleId:id}

  'deleteVehicleDaily' :(id) ->
    Vehicle_Daily.remove id

  'odometerReset':(id, odo) ->
    Vehicles.update id,
      $set :
        odometerCurrent : odo