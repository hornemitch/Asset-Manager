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
  addFurniture: (invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, office, userOfFurniture, description, locate, createdBy) ->
    if Furniture.find().count() != 0
      lastFurniture = Furniture.findOne {}, sort: checkDate : -1
      number = Meteor.call "removeLetters", lastFurniture.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = "FURN" + newNumber
    date = getToday()
    checkDate = new Date()

    Furniture.insert
      assetNumber         : aNum
      status              : "Newly Acquired"
      invoiceNumber       : invoiceNumber
      purchaseOrderNumber : purchaseOrderNumber
      costPrice           : costPrice
      purchaseDate        : purchaseDate
      model               : model
      supplier            : supplier
      manufacturer        : manufacturer
      warrantyExpiration  : warrantyExpiration
      office              : office
      user                : userOfFurniture
      description         : description
      locate              : locate
      createdBy           : createdBy
      createdDate         : date
      checkDate           : checkDate

  'editFurniture' : (id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, office, compUser, compStatus, locationSelect ,description)->


    Furniture.update id ,
      $set :
        invoiceNumber       : invoiceNumber
        purchaseOrderNumber : purchaseOrderNumber
        costPrice           : costPrice
        purchaseDate        : purchaseDate
        model               : model
        supplier            : supplier
        manufacturer        : manufacturer
        warrantyExpiration  : warrantyExpiration
        office              : office
        user                : compUser
        status              : compStatus
        locate              : locationSelect
        description         : description

  'setFurnitureLoststolen': (id, lostStolenDate) ->
    Furniture.update id,
      $set :
        isLostStolen   : true
        lostStolenDate : lostStolenDate

  'setFurnitureScrapped': (id, scrappedTo, scrappedDate) ->
    Furniture.update id,
      $set :
        isScrapped   : true
        scrappedTo   : scrappedTo
        scrappedDate : scrappedDate

  'setFurnitureSold': (id, dateSold, SoldTo, sellPrice) ->
    thisFurniture = Furniture.find id
    profitLoss  = thisFurniture.costPrice - sellPrice

    Furniture.update id,
      $set :
        isSold     : true
        dateSold   : dateSold
        SoldTo     : SoldTo
        sellPrice  : sellPrice
        profitLoss : profitLoss

  deleteFurniture : (furnitureId)->
    Furniture.remove furnitureId