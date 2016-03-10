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
#***Machine methods***
  addMachine: (invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, serial, userOfMachine, description, locate, category, createdBy) ->
#**Variables**
    if Machinery.find().count() != 0
      lastMachine = Machinery.findOne {}, sort: checkDate : -1
      number = Meteor.call "removeLetters", lastMachine.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = "MACH" + newNumber
    checkDate = new Date()
    date = getToday()
    #**Variables**

    Machinery.insert
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
      currentCost         : costPrice
      serialNumber        : serial
      user                : userOfMachine
      description         : description
      locate              : locate
      category            : category
      createdBy           : createdBy
      createdDate         : date
      checkDate           : checkDate

  'editMachine' : (id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, serialNumber, warrantyExpiration, supplier, manufacturer, compUser, compStatus, description, category, location)->
    Machinery.update id ,
      $set :
        invoiceNumber       : invoiceNumber
        purchaseOrderNumber : purchaseOrderNumber
        costPrice           : costPrice
        purchaseDate        : purchaseDate
        model               : model
        serialNumber        : serialNumber
        warrantyExpiration  : warrantyExpiration
        supplier            : supplier
        manufacturer        : manufacturer
        user                : compUser
        status              : compStatus
        description         : description
        category            : category
        locate              : location

  'addMachineCategory' : (name, life)->
    depreciation = 100/life

    Machine_Category.insert
      name         : name
      usefulLife   : life
      depreciation : depreciation

  'editMachineCategory' : (id, name, life)->
    depreciation = 100/life

    Machine_Category.update id,
      $set :
        name         : name
        usefulLife   : life
        depreciation : depreciation

  'addMachineMonth': (id, month, maintenance, revaluation) ->
    date = getToday()

    Machine_Monthly.insert
      machineId   : id
      month       : month
      maintenance : maintenance
      revaluation : revaluation
      createdDate : date
    Machinery.update id,
      $set:
        currentCost : revaluation

  'setMachineLoststolen': (id, lostStolenDate) ->
    Machinery.update id,
      $set :
        isLostStolen   : true
        lostStolenDate : lostStolenDate

  'setMachineScrapped': (id, scrappedTo, scrappedDate) ->
    Machinery.update id,
      $set :
        isScrapped   : true
        scrappedTo   : scrappedTo
        scrappedDate : scrappedDate

  'setMachineSold': (id, dateSold, SoldTo, sellPrice) ->
    thisMachine = Machinery.find id
    profitLoss  = thisMachine.costPrice - sellPrice

    Machinery.update id,
      $set :
        isSold     : true
        dateSold   : dateSold
        SoldTo     : SoldTo
        sellPrice  : sellPrice
        profitLoss : profitLoss

  'deleteMachine' : (id)->
    Machinery.remove id
    Machine_Monthly.remove {machineId : id}

  'deleteMachineMonth' : (id) ->
    Machine_Monthly.remove id