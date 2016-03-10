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
  'addComputer': (invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, serial, user, locate, description, createdBy) ->
    if Computers.find().count() != 0
      lastComputer = Computers.findOne {}, sort: checkDate : -1
      number = Meteor.call "removeLetters", lastComputer.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = "PC" + newNumber
    date = getToday()
    checkDate = new Date()

    Computers.insert
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
      serialNumber        : serial
      user                : user
      locate              : locate
      description         : description
      createdBy           : createdBy
      createdDate         : date
      checkDate           : checkDate

  'editComputer' : (id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, warrantyExpiration, serialNumber, compUser, supplier, manufacturer, locate, compStatus, description)->
    Computers.update id ,
      $set :
        invoiceNumber       : invoiceNumber
        purchaseOrderNumber : purchaseOrderNumber
        costPrice           : costPrice
        purchaseDate        : purchaseDate
        model               : model
        supplier            : supplier
        manufacturer        : manufacturer
        warrantyExpiration  : warrantyExpiration
        serialNumber        : serialNumber
        user                : compUser
        locate              : locate
        status              : compStatus
        description         : description

  'addSoftware': (id, name, installed, licenceKey, licenceRenewalDate, purchaseCost, acquiredDate, supplier, developer, invoiceNumber, purchaseOrder, description ) ->
    if Computer_Software.find().count() != 0
      lastSoftware = Computer_Software.findOne {}, sort: checkDate : -1
      number = Meteor.call "removeLetters", lastSoftware.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = "SOFT" + newNumber
    date = getToday()

    Computer_Software.insert
      computerId         : id
      assetNumber        : aNum
      status             : 'Newly Acquired'
      name               : name
      installed          : installed
      licenceKey         : licenceKey
      licenceRenewalDate : licenceRenewalDate
      purchaseCost       : purchaseCost
      acquiredDate       : acquiredDate
      supplier           : supplier
      developer          : developer
      invoiceNumber      : invoiceNumber
      purchaseOrder      : purchaseOrder
      description        : description
      createdDate        : date

  'editSoftware': (id, status, name, installed, licenceKey, licenceRenewalDate, purchaseCost, acquiredDate, supplier, developer, invoiceNumber, purchaseOrder, description) ->
    Computer_Software.update id,
      $set :
        status             : status
        name               : name
        installed          : installed
        licenceKey         : licenceKey
        licenceRenewalDate : licenceRenewalDate
        purchaseCost       : purchaseCost
        acquiredDate       : acquiredDate
        supplier           : supplier
        developer          : developer
        invoiceNumber      : invoiceNumber
        purchaseOrder      : purchaseOrder
        description        : description

  'setComputerLoststolen': (id, lostStolenDate) ->
    Computers.update id,
      $set :
        isLostStolen   : true
        lostStolenDate : lostStolenDate

  'setComputerScrapped': (id, scrappedTo, scrappedDate) ->
    Computers.update id,
      $set :
        isScrapped   : true
        scrappedTo   : scrappedTo
        scrappedDate : scrappedDate

  'setComputerSold': (id, dateSold, SoldTo, sellPrice) ->
    thisComputer = Computers.find id
    profitLoss  = thisComputer.costPrice - sellPrice

    Computers.update id,
      $set :
        isSold     : true
        dateSold   : dateSold
        SoldTo     : SoldTo
        sellPrice  : sellPrice
        profitLoss : profitLoss

  'deleteComputer' : (id)->
    Computer_Software.reomve {computerId : id}
    Computers.remove id

  'deleteSoftware' : (id) ->
    Computer_Software.remove id