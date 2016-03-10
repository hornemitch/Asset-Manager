###
    * * * * * * * * * * *
      Building Methods
    * * * * * * * * * * *
###

Meteor.methods
  # * * Add Building Method * * #
  'addBuilding': (purchaseCost, purchaseDate, propertyId, locate, buildName, user, description, type) ->
    if Buildings.find().count() != 0
      lastBuilding = Buildings.findOne {}, sort: checkDate : -1
      myNumber = Meteor.call 'removeLetters', lastBuilding.assetNumber
      number = parseInt myNumber
      newNumber = ++number
    else
      newNumber = 0

    aNum = "B" + newNumber
    date = getToday()
    checkDate = new Date()

    Buildings.insert
      assetNumber  : aNum
      status       : 'Newly Acquired'
      purchaseCost : purchaseCost
      purchaseDate : purchaseDate
      propertyId   : propertyId
      buildingName : buildName
      locate       : locate
      currentValue : purchaseCost
      description  : description
      type         : type
      createdBy    : user
      createdDate  : date
      checkDate    : checkDate

  # * * Edit Building Method * * #
  'editBuilding' : (id,building, status, purchaseCost, purchaseDate, propertyId, locate, description, type)->
    Buildings.update id ,
      $set :
        buildingName : building
        status       : status
        purchaseCost : purchaseCost
        purchaseDate : purchaseDate
        propertyId   : propertyId
        locate       : locate
        description  : description
        type         : type

  # * * Set Building to Destroyed Method * * #
  'buildingDestroyed' : (buildingId) ->
    date = getToday()
    Buildings.update buildingId,
      $set:
        destroyed     : true
        destroyedDate : date

  # * * Add Building Revaluation Method * * #
  'buildingRevaluate' : (id, value, date, buildingPrevValue) ->

    today = new Date()

    Building_Revaluation.insert
      buildingId             : id
      value                  : value
      dateOfRevalue          : date
      prevValue              : buildingPrevValue
      createdDate            : today

    Buildings.update id ,
      $set :
        currentValue : value

  # * * Remove Building Revaluation Method * * #
  'buildingRevalateRemove' :(id) ->
    Building_Revaluation.remove id

  # * * Reset Building Last Current Value Method * * #
  'resetBuildingValue':(id, prevValue) ->
    Buildings.update id,
      $set:
        currentValue : prevValue

  'buildingImprovement' : (id, value, date, description) ->
    curDate = new Date()

    Building_Improvement.insert
      buildingId    : id
      value         : value
      dateOfImprove : date
      description   : description
      createdDate   : curDate

  'buildingImprovementRemove' : (id) ->
    Building_Improvement.remove id

  'buildingImpairment' : (id, value, date, description) ->
    curDate = new Date()

    Building_Impairment.insert
      buildingId   : id
      value        : value
      dateOfImpair : date
      description  : description
      createdDate  : curDate

  'buildingImpairmentRemove' : (id) ->
    Building_Impairment.remove id

  'deleteBuilding' : (id) ->
    Buildings.remove id
    Building_Impairment.remove {buildingId:id}
    Building_Improvement.remove {buildingId:id}
    Building_Revaluation.remove {buildingId:id}