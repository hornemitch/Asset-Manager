# * * Current Date Creation Function * * #
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

###
  * * * * * * * * * * *
    Cellphone Methods
  * * * * * * * * * * *
###

Meteor.methods

  ###
    * * * * * * * * * * * * * * * *
      Cellphone Creation Methods
    * * * * * * * * * * * * * * * *
  ###

# * * Method for Contract Cellphone Creation * * #
  'addCellphone': (invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration,cellNumber, user, contractStart, contractEnd, location, pin, puk, sim, description, createdBy) ->

    if Cellphones.find().count() != 0
      lastCellphone = Cellphones.findOne {}, sort: checkDate : -1
      number = Meteor.call 'removeLetters', lastCellphone.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = 'CELL' + newNumber
    date = getToday()
    checkDate = new Date()

    Cellphones.insert
      assetNumber         : aNum
      status              : 'Newly Acquired'
      invoiceNumber       : invoiceNumber
      purchaseOrderNumber : purchaseOrderNumber
      costPrice           : costPrice
      purchaseDate        : purchaseDate
      model               : model
      supplier            : supplier
      manufacturer        : manufacturer
      warrantyExpiration  : warrantyExpiration
      number              : cellNumber
      user                : user
      hasContract         : true
      contractStart       : contractStart
      contractEnd         : contractEnd
      location            : location
      pin                 : pin
      puk                 : puk
      sim                 : sim
      description         : description
      createdBy           : createdBy
      createdDate         : date
      checkDate           : checkDate

# * * Method for Non-Contract Cellphone * * #
  'addCellphoneNoSub': (invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, cellNumber, user, location, pin, puk, sim, description, createdBy) ->

    if Cellphones.find().count() != 0
      lastCellphone = Cellphones.findOne {}, sort: checkDate : -1
      number = Meteor.call 'removeLetters', lastCellphone.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = 'CELL' + newNumber
    date = getToday()
    checkDate = new Date()

    Cellphones.insert
      assetNumber         : aNum
      status              : 'Newly Acquired'
      invoiceNumber       : invoiceNumber
      purchaseOrderNumber : purchaseOrderNumber
      costPrice           : costPrice
      purchaseDate        : purchaseDate
      model               : model
      supplier            : supplier
      manufacturer        : manufacturer
      warrantyExpiration  : warrantyExpiration
      number              : cellNumber
      user                : user
      hasContract         : false
      contractStart       : null
      contractEnd         : null
      location            : location
      pin                 : pin
      puk                 : puk
      sim                 : sim
      description         : description
      createdBy           : createdBy
      createdDate         : date
      checkDate           : checkDate

  ###
    * * * * * * * * * * * * * * *
      Cellphone Editing Methods
    * * * * * * * * * * * * * * *
  ###

# * * Method to Edit Contract Cellphones * * #
  'editCellphone' : (id, status, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, number, user, contractStart, contractEnd, location, pin, puk, sim, description)->
    Cellphones.update id ,
      $set :
        status              : status
        invoiceNumber       : invoiceNumber
        purchaseOrderNumber : purchaseOrderNumber
        costPrice           : costPrice
        purchaseDate        : purchaseDate
        model               : model
        supplier            : supplier
        manufacturer        : manufacturer
        warrantyExpiration  : warrantyExpiration
        number              : number
        user                : user
        hasContract         : true
        contractStart       : contractStart
        contractEnd         : contractEnd
        location            : location
        pin                 : pin
        puk                 : puk
        sim                 : sim
        description         : description

# * * Method to Edit Non-Contract Cellphones * * #
  'editNoSubCellphone' : (id, status, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, number, user, location, pin, puk, sim, description)->
    Cellphones.update id ,
      $set :
        status              : status
        invoiceNumber       : invoiceNumber
        purchaseOrderNumber : purchaseOrderNumber
        costPrice           : costPrice
        purchaseDate        : purchaseDate
        model               : model
        supplier            : supplier
        manufacturer        : manufacturer
        warrantyExpiration  : warrantyExpiration
        number              : number
        user                : user
        hasContract         : false
        contractStart       : null
        contractEnd         : null
        location            : location
        pin                 : pin
        puk                 : puk
        sim                 : sim
        description         : description

  ###
    * * * * * * * * * * * * * * *
      Cellphone Removal Methods
    * * * * * * * * * * * * * * *
  ###

# * * Method to Set Cellphone to Lost or Stolen Status * * #
  'setCellLostStolen': (id, lostStolenDate) ->
    Cellphones.update id,
      $set :
        isLostStolen   : true
        lostStolenDate : lostStolenDate

# * * Method to Set Cellphone to Scrapped Status * * #
  'setCellScrapped': (id, scrappedTo, scrappedDate) ->
    Cellphones.update id,
      $set :
        isScrapped   : true
        scrappedTo   : scrappedTo
        scrappedDate : scrappedDate

# * * Method to Set Cellphone to Sold Status * * #
  'setCellSold': (id, dateSold, SoldTo, sellPrice) ->
    thisPhone  = Cellphones.find id
    profitLoss = thisPhone.costPrice - sellPrice

    Cellphones.update id,
      $set :
        isSold     : true
        dateSold   : dateSold
        SoldTo     : SoldTo
        sellPrice  : sellPrice
        profitLoss : profitLoss

# * * Method to Delete Cellphone * * #
  'deleteCellphone' : (cellId)->
    Cellphone_Monthly.remove {cellphoneId : cellId }
    Cellphones.remove cellId

  ###
    * * * * * * * * * * * * * * *
      Cellphone Monthly Methods
    * * * * * * * * * * * * * * *
  ###

# * * Method to Add Cellphone Monthly Records with Subscription * * #
  'addCellphoneSubMonth': (id, Month, subscriptionTotal, callsCost, dataCost, other, itemBill, comment) ->

    date = getToday()
    difference = itemBill - subscriptionTotal
    difference = difference.toFixed(2)

    Cellphone_Monthly.insert
      cellphoneId       : id
      month             : Month
      subscriptionTotal : subscriptionTotal
      totalBill         : itemBill
      callsCost         : callsCost
      dataServices      : dataCost
      other             : other
      difference        : difference
      comment           : comment
      createdDate       : date

# * * Method to Add Cellphone Monthly Records with no Subscription * * #
  'addCellphoneNoSubMonth': (id, month, airtimeCosts, dataCosts, itemBill, comment) ->

    date = getToday()

    Cellphone_Monthly.insert
      cellphoneId       : id
      month             : month
      airtimeCosts      : airtimeCosts
      dataCosts         : dataCosts
      totalBill         : itemBill
      comment           : comment
      createdDate       : date

# * * Method to Delete a Cellphone Monthly Record* * #
  deleteMonth : (id) ->
    Cellphone_Monthly.remove id