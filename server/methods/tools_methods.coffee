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
#***Tool methods***
  addTool: (invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, serial, certificationNumber, calibrationDate, renewalDate, locate, category, description, createdBy) ->
#**Variables**
    if Tools.find().count() != 0
      lastTool = Tools.findOne {}, sort: checkDate : -1
      number = Meteor.call "removeLetters", lastTool.assetNumber
      number = parseInt number
      newNumber = ++number
    else
      newNumber = 0

    aNum = "TOOL" + newNumber
    checkDate = new Date()
    date = getToday()
    #**Variables**

    Tools.insert
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
      certificationNumber : certificationNumber
      calibrationDate     : calibrationDate
      renewalDate         : renewalDate
      locate              : locate
      category            : category
      description         : description
      createdBy           : createdBy
      createdDate         : date
      checkDate           : checkDate

  'addToolCategory' : (name, life)->
    depreciation = 100/life

    Tool_Category.insert
      name         : name
      usefulLife   : life
      depreciation : depreciation

  'editToolCategory' : (id, name, life)->
    depreciation = 100/life

    Tool_Category.update id,
      $set:
        name         : name
        usefulLife   : life
        depreciation : depreciation

  'editTool': (id, invoiceNumber, purchaseOrderNumber, costPrice, purchaseDate, model, supplier, manufacturer, warrantyExpiration, serial, status, categorySelect, locationSelect, certificationNumber, calibrationDate, renewalDate, description)->
    Tools.update id,
      $set:
        invoiceNumber       : invoiceNumber
        purchaseOrderNumber : purchaseOrderNumber
        costPrice           : costPrice
        purchaseDate        : purchaseDate
        model               : model
        supplier            : supplier
        manufacturer        : manufacturer
        warrantyExpiration  : warrantyExpiration
        serialNumber        : serial
        status              : status
        category            : categorySelect
        locate              : locationSelect
        certificationNumber : certificationNumber
        calibrationDate     : calibrationDate
        renewalDate         : renewalDate
        description         : description

  'setToolLoststolen': (id, lostStolenDate) ->
    Tools.update id,
      $set :
        isLostStolen   : true
        lostStolenDate : lostStolenDate

  'setToolScrapped': (id, scrappedTo, scrappedDate) ->
    Tools.update id,
      $set :
        isScrapped   : true
        scrappedTo   : scrappedTo
        scrappedDate : scrappedDate

  'setToolSold': (id, dateSold, SoldTo, sellPrice) ->
    thisTool = Tools.find id
    profitLoss  = thisTool.costPrice - sellPrice

    Tools.update id,
      $set :
        isSold     : true
        dateSold   : dateSold
        SoldTo     : SoldTo
        sellPrice  : sellPrice
        profitLoss : profitLoss

  deleteTool : (toolId)->
    Tools.remove toolId

  'deleteToolCategory': (id)->
    Tool_Category.remove id