###
  * * * * * * * * * * * * * * * * *
    Asset Overview Report Creation
  * * * * * * * * * * * * * * * * *
###

Template.overview_cost.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'reports'

Template.overview_cost.helpers
  'showCostValue': (number) ->
    number = parseFloat number
    number = number.toFixed(2)
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  ###
    * * * * * * * * * *
      Building Helpers
    * * * * * * * * * *
  ###
  'buildingNumber': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildings = 0

    buildings.forEach ->
      totalBuildings++

    return totalBuildings

  'buildingTotal': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildingCost = 0

    buildings.forEach (building) ->
      totalBuildingCost += parseFloat building.purchaseCost

    Session.set('totalBuildingCost', totalBuildingCost)

    return totalBuildingCost

  'buildingDepreciation': ->
    Meteor.subscribe 'buildings'
    Meteor.subscribe 'usefulLife'
    buildings = Buildings.find()
    depreciationRate = UsefulLife.findOne({name:'Buildings'}).depreciation

    totalDepreciation = 0

    buildings.forEach (building) ->
      if building.type == true
        buyDate  = building.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate       = new Date()
        newMonth      = nowDate.getMonth() + 1
        newYear       = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        depreciation =(parseFloat building.purchaseCost * (depreciationRate/100/12 * months))

        totalDepreciation += depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalBuildingDep', totalDepreciation)
    return totalDepreciation

  'buildingBookValue': ->
    buildingCosts = Session.get 'totalBuildingCost'
    buildingDepreciation = Session.get 'totalBuildingDep'

    totalBookValue = buildingCosts - buildingDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('buildingBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Cellphone Helpers
    * * * * * * * * * *
  ###

  'cellphoneNumber': ->
    Meteor.subscribe 'cellphones'
    cellphones = Cellphones.find()

    totalCellphones = 0

    cellphones.forEach ->
      totalCellphones++

    return totalCellphones

  'cellphoneCosts': ->
    Meteor.subscribe 'cellphones'
    cellphones = Cellphones.find()

    totalCellphoneCost = 0

    cellphones.forEach (cellphone) ->
      totalCellphoneCost += parseFloat cellphone.costPrice

    Session.set('totalCellCost', totalCellphoneCost)
    return totalCellphoneCost

  'cellphoneDepreciation': ->
    Meteor.subscribe 'cellphones'
    Meteor.subscribe 'usefulLife'
    cellphones = Cellphones.find()
    depreciationRate = UsefulLife.findOne({name:'Cellphones'}).depreciation

    totalDepreciation = 0

    cellphones.forEach (cellphone) ->
      buyDate  = cellphone.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat cellphone.costPrice * (depreciationRate/100/12 * months))

      totalDepreciation += depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalCellDep', totalDepreciation)
    return totalDepreciation

  'cellphoneBookvalue': ->
    cellphoneCosts = Session.get 'totalCellCost'
    cellphoneDepreciation = Session.get 'totalCellDep'

    totalBookValue = cellphoneCosts - cellphoneDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('cellphoneBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Computer Helpers
    * * * * * * * * * *
  ###

  'computerNumber': ->
    Meteor.subscribe 'computers'
    computers = Computers.find()

    totalComputers = 0

    computers.forEach ->
      totalComputers++

    return totalComputers

  'computerCosts': ->
    Meteor.subscribe 'computers'
    computers = Computers.find()

    totalComputerCost = 0

    computers.forEach (computer) ->
      cost = parseFloat computer.costPrice
      totalComputerCost += cost

    Session.set('totalCompCost', totalComputerCost)
    return totalComputerCost

  'computerDepreciation': ->
    Meteor.subscribe 'computers'
    Meteor.subscribe 'usefulLife'
    computers = Computers.find()
    depreciationRate = UsefulLife.findOne({name:'Computers'}).depreciation

    totalDepreciation = 0

    computers.forEach (computer) ->
      buyDate  = computer.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat computer.costPrice * (depreciationRate/100/12 * months))

      totalDepreciation += depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalCompDep', totalDepreciation)
    return totalDepreciation

  'computerBookvalue': ->
    computerCosts = Session.get 'totalCompCost'
    computerDepreciation = Session.get 'totalCompDep'

    totalBookValue = computerCosts - computerDepreciation
    Session.set('computerBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Furniture Helpers
    * * * * * * * * * *
  ###

  'furnitureNumber': ->
    Meteor.subscribe 'furniture'
    furniture = Furniture.find()

    totalFurniture = 0

    furniture.forEach ->
      totalFurniture++

    return totalFurniture

  'furnitureCosts': ->
    Meteor.subscribe 'furniture'
    furniture = Furniture.find()

    totalFurnitureCost = 0

    furniture.forEach (furniture) ->
      cost = parseFloat furniture.costPrice
      totalFurnitureCost += cost

    Session.set('totalFurnCost', totalFurnitureCost)
    return totalFurnitureCost

  'furnitureDepreciation': ->
    Meteor.subscribe 'furniture'
    Meteor.subscribe 'usefulLife'
    furniture = Furniture.find()
    depreciationRate = UsefulLife.findOne({name:'Furniture'}).depreciation

    totalDepreciation = 0

    furniture.forEach (furniture) ->
      buyDate  = furniture.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      cp = parseFloat furniture.costPrice
      dr = parseFloat depreciationRate
      depreciation =(cp * (dr/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalFurnDep', totalDepreciation)
    return totalDepreciation

  'furnitureBookvalue': ->
    furnitureCosts = Session.get 'totalFurnCost'
    furnitureDepreciation = Session.get 'totalFurnDep'

    totalBookValue = furnitureCosts - furnitureDepreciation
    Session.set('furnitureBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Machinery Helpers
    * * * * * * * * * *
  ###

  'machineryNumber': ->
    Meteor.subscribe 'machinery'
    machinery = Machinery.find()

    totalMachinery = 0

    machinery.forEach ->
      totalMachinery++

    return totalMachinery

  'machineryCosts': ->
    Meteor.subscribe 'machinery'
    machinery = Machinery.find()

    totalMachineryCost = 0

    machinery.forEach (machine) ->
      cost = parseFloat machine.costPrice
      totalMachineryCost = totalMachineryCost + cost

    Session.set('totalMachCost', totalMachineryCost)
    return totalMachineryCost

  'machineryDepreciation': ->
    Meteor.subscribe 'machinery'
    Meteor.subscribe 'machine_category'
    machinery = Machinery.find()

    totalDepreciation = 0

    machinery.forEach (machine) ->
      machineCategory =  machine.category
      category = Machine_Category.findOne(machineCategory)
      category_depreciation = category.depreciation

      buyDate  = machine.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat machine.costPrice * (parseFloat category_depreciation/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalMachDep', totalDepreciation)
    return totalDepreciation

  'machineryBookvalue': ->
    machineryCosts = Session.get 'totalMachCost'
    machineryDepreciation = Session.get 'totalMachDep'

    totalBookValue = machineryCosts - machineryDepreciation
    Session.set('machineryBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * *
      Tools Helpers
    * * * * * * * * *
  ###

  'toolNumber': ->
    Meteor.subscribe 'tools'
    tools = Tools.find()

    totalTools = 0

    tools.forEach ->
      totalTools++

    return totalTools

  'toolCosts': ->
    Meteor.subscribe 'tools'
    tools = Tools.find()

    totalToolsCost = 0

    tools.forEach (tool) ->
      cost = parseFloat tool.costPrice
      totalToolsCost = totalToolsCost + cost

    Session.set('totalToolCost', totalToolsCost)
    return totalToolsCost

  'toolDepreciation': ->
    Meteor.subscribe 'tools'
    Meteor.subscribe 'tool_category'
    tools = Tools.find()

    totalDepreciation = 0

    tools.forEach (tool) ->
      toolCategory =  tool.category
      category = Tool_Category.findOne(toolCategory)
      category_depreciation = category.depreciation

      buyDate  = tool.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat tool.costPrice * (parseFloat category_depreciation/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalToolDep', totalDepreciation)
    return totalDepreciation

  'toolBookvalue': ->
    toolCosts = Session.get 'totalToolCost'
    toolDepreciation = Session.get 'totalToolDep'

    totalBookValue = toolCosts - toolDepreciation
    Session.set('toolBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Vehicle Helpers
    * * * * * * * * * *
  ###

  'vehicleNumber': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()

    totalVehicles = 0

    vehicles.forEach ->
      totalVehicles++

    return totalVehicles

  'vehicleCosts': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()

    totalVehiclesCost = 0

    vehicles.forEach (vehicle) ->
      cost = parseFloat vehicle.costPrice
      totalVehiclesCost = totalVehiclesCost + cost

    Session.set('totalVehicleCost', totalVehiclesCost)
    return totalVehiclesCost

  'vehicleDepreciation': ->
    Meteor.subscribe 'vehicles'
    Meteor.subscribe 'vehicle_category'
    vehicles = Vehicles.find()

    totalDepreciation = 0

    vehicles.forEach (vehicle) ->
      vehicleCategory =  vehicle.category
      category = Vehicle_Category.findOne(vehicleCategory)
      category_depreciation = category.depreciation

      buyDate  = vehicle.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      cp = parseFloat vehicle.costPrice
      dr = parseFloat category_depreciation
      depreciation =(cp * (dr/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalVehicleDep', totalDepreciation)
    return totalDepreciation

  'vehicleBookvalue': ->
    vehiclesCosts = Session.get 'totalVehicleCost'
    vehiclesDepreciation = Session.get 'totalVehicleDep'

    totalBookValue = vehiclesCosts - vehiclesDepreciation
    Session.set('vehicleBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Totals Helpers
    * * * * * * * * * *
  ###

  'totalCosts': ->
    buildings = parseFloat Session.get 'totalBuildingCost'
    cellphones= parseFloat Session.get 'totalCellCost'
    computers = parseFloat Session.get 'totalCompCost'
    furniture = parseFloat Session.get 'totalFurnCost'
    machinery = parseFloat Session.get 'totalMachCost'
    tools     = parseFloat Session.get 'totalToolCost'
    vehicles  = parseFloat Session.get 'totalVehicleCost'

    total     = buildings + cellphones + computers + furniture + machinery + tools + vehicles
    total = total.toFixed(2)
    return total

  'totalDep': ->
    buildings = parseFloat Session.get 'totalBuildingDep'
    cellphones= parseFloat Session.get 'totalCellDep'
    computers = parseFloat Session.get 'totalCompDep'
    furniture = parseFloat Session.get 'totalFurnDep'
    machinery = parseFloat Session.get 'totalMachDep'
    tools     = parseFloat Session.get 'totalToolDep'
    vehicles  = parseFloat Session.get 'totalVehicleDep'

    total = buildings + cellphones + computers + furniture + machinery + tools + vehicles
    total = total.toFixed(2)
    return total

  'totalValue': ->
    buildings = parseFloat Session.get 'buildingBookValue'
    cellphones= parseFloat Session.get 'cellphoneBookValue'
    computers = parseFloat Session.get 'computerBookValue'
    furniture = parseFloat Session.get 'furnitureBookValue'
    machinery = parseFloat Session.get 'machineryBookValue'
    tools     = parseFloat Session.get 'toolBookValue'
    vehicles  = parseFloat Session.get 'vehicleBookValue'

    total = buildings + cellphones + computers + furniture + machinery + tools + vehicles
    total = total.toFixed(2)
    return total

###
  * * * * * * * * * * * * * * * * * * * *
    Asset Overview Report Print Creation
  * * * * * * * * * * * * * * * * * * * *
###

Template.overview_cost_print.onRendered ->
  window.print()
  Router.go 'overviewCostReport'

Template.overview_cost_print.helpers
  'showCostValue': (number) ->
    number = parseFloat number
    number = number.toFixed(2)
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  'showValue': (number) ->
    number += ''
    x = number.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else '.00'
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ' ' + '$2')
    return x1 + x2

  ###
    * * * * * * * * * *
      Building Helpers
    * * * * * * * * * *
  ###
  'buildingNumber': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildings = 0

    buildings.forEach ->
      totalBuildings++

    return totalBuildings

  'buildingTotal': ->
    Meteor.subscribe 'buildings'
    buildings = Buildings.find()

    totalBuildingCost = 0

    buildings.forEach (building) ->
      totalBuildingCost += parseFloat building.purchaseCost

    Session.set('totalBuildingCost', totalBuildingCost)

    return totalBuildingCost

  'buildingDepreciation': ->
    Meteor.subscribe 'buildings'
    Meteor.subscribe 'usefulLife'
    buildings = Buildings.find()
    depreciationRate = UsefulLife.findOne({name:'Buildings'}).depreciation

    totalDepreciation = 0

    buildings.forEach (building) ->
      if building.type == true
        buyDate  = building.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate       = new Date()
        newMonth      = nowDate.getMonth() + 1
        newYear       = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        depreciation =(parseFloat building.purchaseCost * (depreciationRate/100/12 * months))

        totalDepreciation += depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalBuildingDep', totalDepreciation)
    return totalDepreciation

  'buildingBookValue': ->
    buildingCosts = Session.get 'totalBuildingCost'
    buildingDepreciation = Session.get 'totalBuildingDep'

    totalBookValue = buildingCosts - buildingDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('buildingBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Cellphone Helpers
    * * * * * * * * * *
  ###

  'cellphoneNumber': ->
    Meteor.subscribe 'cellphones'
    cellphones = Cellphones.find()

    totalCellphones = 0

    cellphones.forEach ->
      totalCellphones++

    return totalCellphones

  'cellphoneCosts': ->
    Meteor.subscribe 'cellphones'
    cellphones = Cellphones.find()

    totalCellphoneCost = 0

    cellphones.forEach (cellphone) ->
      totalCellphoneCost += parseFloat cellphone.costPrice

    Session.set('totalCellCost', totalCellphoneCost)
    return totalCellphoneCost

  'cellphoneDepreciation': ->
    Meteor.subscribe 'cellphones'
    Meteor.subscribe 'usefulLife'
    cellphones = Cellphones.find()
    depreciationRate = UsefulLife.findOne({name:'Cellphones'}).depreciation

    totalDepreciation = 0

    cellphones.forEach (cellphone) ->
      buyDate  = cellphone.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat cellphone.costPrice * (depreciationRate/100/12 * months))

      totalDepreciation += depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalCellDep', totalDepreciation)
    return totalDepreciation

  'cellphoneBookvalue': ->
    cellphoneCosts = Session.get 'totalCellCost'
    cellphoneDepreciation = Session.get 'totalCellDep'

    totalBookValue = cellphoneCosts - cellphoneDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('cellphoneBookValue', totalBookValue)

    totalBookValue = totalBookValue.toFixed(2)

    return totalBookValue

  ###
    * * * * * * * * * *
      Computer Helpers
    * * * * * * * * * *
  ###

  'computerNumber': ->
    Meteor.subscribe 'computers'
    computers = Computers.find()

    totalComputers = 0

    computers.forEach ->
      totalComputers++

    return totalComputers

  'computerCosts': ->
    Meteor.subscribe 'computers'
    computers = Computers.find()

    totalComputerCost = 0

    computers.forEach (computer) ->
      cost = parseFloat computer.costPrice
      totalComputerCost += cost

    Session.set('totalCompCost', totalComputerCost)
    return totalComputerCost

  'computerDepreciation': ->
    Meteor.subscribe 'computers'
    Meteor.subscribe 'usefulLife'
    computers = Computers.find()
    depreciationRate = UsefulLife.findOne({name:'Computers'}).depreciation

    totalDepreciation = 0

    computers.forEach (computer) ->
      buyDate  = computer.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat computer.costPrice * (depreciationRate/100/12 * months))

      totalDepreciation += depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalCompDep', totalDepreciation)
    return totalDepreciation

  'computerBookvalue': ->
    computerCosts = Session.get 'totalCompCost'
    computerDepreciation = Session.get 'totalCompDep'

    totalBookValue = computerCosts - computerDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('computerBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Furniture Helpers
    * * * * * * * * * *
  ###

  'furnitureNumber': ->
    Meteor.subscribe 'furniture'
    furniture = Furniture.find()

    totalFurniture = 0

    furniture.forEach ->
      totalFurniture++

    return totalFurniture

  'furnitureCosts': ->
    Meteor.subscribe 'furniture'
    furniture = Furniture.find()

    totalFurnitureCost = 0

    furniture.forEach (furniture) ->
      cost = parseFloat furniture.costPrice
      totalFurnitureCost += cost

    Session.set('totalFurnCost', totalFurnitureCost)
    return totalFurnitureCost

  'furnitureDepreciation': ->
    Meteor.subscribe 'furniture'
    Meteor.subscribe 'usefulLife'
    furniture = Furniture.find()
    depreciationRate = UsefulLife.findOne({name:'Furniture'}).depreciation

    totalDepreciation = 0

    furniture.forEach (furniture) ->
      buyDate  = furniture.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      cp = parseFloat furniture.costPrice
      dr = parseFloat depreciationRate
      depreciation =(cp * (dr/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalFurnDep', totalDepreciation)
    return totalDepreciation

  'furnitureBookvalue': ->
    furnitureCosts = Session.get 'totalFurnCost'
    furnitureDepreciation = Session.get 'totalFurnDep'

    totalBookValue = furnitureCosts - furnitureDepreciation
    totalBookValue = totalBookValue.tpFixed(2)
    Session.set('furnitureBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Machinery Helpers
    * * * * * * * * * *
  ###

  'machineryNumber': ->
    Meteor.subscribe 'machinery'
    machinery = Machinery.find()

    totalMachinery = 0

    machinery.forEach ->
      totalMachinery++

    return totalMachinery

  'machineryCosts': ->
    Meteor.subscribe 'machinery'
    machinery = Machinery.find()

    totalMachineryCost = 0

    machinery.forEach (machine) ->
      cost = parseFloat machine.costPrice
      totalMachineryCost = totalMachineryCost + cost

    Session.set('totalMachCost', totalMachineryCost)
    return totalMachineryCost

  'machineryDepreciation': ->
    Meteor.subscribe 'machinery'
    Meteor.subscribe 'machine_category'
    machinery = Machinery.find()

    totalDepreciation = 0

    machinery.forEach (machine) ->
      machineCategory =  machine.category
      category = Machine_Category.findOne(machineCategory)
      category_depreciation = category.depreciation

      buyDate  = machine.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat machine.costPrice * (parseFloat category_depreciation/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalMachDep', totalDepreciation)
    return totalDepreciation

  'machineryBookvalue': ->
    machineryCosts = Session.get 'totalMachCost'
    machineryDepreciation = Session.get 'totalMachDep'

    totalBookValue = machineryCosts - machineryDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('machineryBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * *
      Tools Helpers
    * * * * * * * * *
  ###

  'toolNumber': ->
    Meteor.subscribe 'tools'
    tools = Tools.find()

    totalTools = 0

    tools.forEach ->
      totalTools++

    return totalTools

  'toolCosts': ->
    Meteor.subscribe 'tools'
    tools = Tools.find()

    totalToolsCost = 0

    tools.forEach (tool) ->
      cost = parseFloat tool.costPrice
      totalToolsCost = totalToolsCost + cost

    Session.set('totalToolCost', totalToolsCost)
    return totalToolsCost

  'toolDepreciation': ->
    Meteor.subscribe 'tools'
    Meteor.subscribe 'tool_category'
    tools = Tools.find()

    totalDepreciation = 0

    tools.forEach (tool) ->
      toolCategory =  tool.category
      category = Tool_Category.findOne(toolCategory)
      category_depreciation = category.depreciation

      buyDate  = tool.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      depreciation =(parseFloat tool.costPrice * (parseFloat category_depreciation/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalToolDep', totalDepreciation)
    return totalDepreciation

  'toolBookvalue': ->
    toolCosts = Session.get 'totalToolCost'
    toolDepreciation = Session.get 'totalToolDep'

    totalBookValue = toolCosts - toolDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('toolBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Vehicle Helpers
    * * * * * * * * * *
  ###

  'vehicleNumber': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()

    totalVehicles = 0

    vehicles.forEach ->
      totalVehicles++

    return totalVehicles

  'vehicleCosts': ->
    Meteor.subscribe 'vehicles'
    vehicles = Vehicles.find()

    totalVehiclesCost = 0

    vehicles.forEach (vehicle) ->
      cost = parseFloat vehicle.costPrice
      totalVehiclesCost = totalVehiclesCost + cost

    Session.set('totalVehicleCost', totalVehiclesCost)
    return totalVehiclesCost

  'vehicleDepreciation': ->
    Meteor.subscribe 'vehicles'
    Meteor.subscribe 'vehicle_category'
    vehicles = Vehicles.find()

    totalDepreciation = 0

    vehicles.forEach (vehicle) ->
      vehicleCategory =  vehicle.category
      category = Vehicle_Category.findOne(vehicleCategory)
      category_depreciation = category.depreciation

      buyDate  = vehicle.purchaseDate
      split    = buyDate.split('-')

      oldMonth = split[1]
      oldYear  = split[2]

      nowDate       = new Date()
      newMonth      = nowDate.getMonth() + 1
      newYear       = nowDate.getFullYear()

      months = (newYear - oldYear)*12 + (newMonth - oldMonth)
      cp = parseFloat vehicle.costPrice
      dr = parseFloat category_depreciation
      depreciation =(cp * (dr/100/12 * months))

      totalDepreciation = totalDepreciation + depreciation

    totalDepreciation = totalDepreciation.toFixed(2)
    Session.set('totalVehicleDep', totalDepreciation)
    return totalDepreciation

  'vehicleBookvalue': ->
    vehiclesCosts = Session.get 'totalVehicleCost'
    vehiclesDepreciation = Session.get 'totalVehicleDep'

    totalBookValue = vehiclesCosts - vehiclesDepreciation
    totalBookValue = totalBookValue.toFixed(2)
    Session.set('vehicleBookValue', totalBookValue)

    return totalBookValue

  ###
    * * * * * * * * * *
      Totals Helpers
    * * * * * * * * * *
  ###

  'totalCosts': ->
    buildings = parseFloat Session.get 'totalBuildingCost'
    cellphones= parseFloat Session.get 'totalCellCost'
    computers = parseFloat Session.get 'totalCompCost'
    furniture = parseFloat Session.get 'totalFurnCost'
    machinery = parseFloat Session.get 'totalMachCost'
    tools     = parseFloat Session.get 'totalToolCost'
    vehicles  = parseFloat Session.get 'totalVehicleCost'

    total     = buildings + cellphones + computers + furniture + machinery + tools + vehicles
    total = total.toFixed(2)
    return total

  'totalDep': ->
    buildings = parseFloat Session.get 'totalBuildingDep'
    cellphones= parseFloat Session.get 'totalCellDep'
    computers = parseFloat Session.get 'totalCompDep'
    furniture = parseFloat Session.get 'totalFurnDep'
    machinery = parseFloat Session.get 'totalMachDep'
    tools     = parseFloat Session.get 'totalToolDep'
    vehicles  = parseFloat Session.get 'totalVehicleDep'

    total = buildings + cellphones + computers + furniture + machinery + tools + vehicles
    total = total.toFixed(2)
    return total

  'totalValue': ->
    buildings = parseFloat Session.get 'buildingBookValue'
    cellphones= parseFloat Session.get 'cellphoneBookValue'
    computers = parseFloat Session.get 'computerBookValue'
    furniture = parseFloat Session.get 'furnitureBookValue'
    machinery = parseFloat Session.get 'machineryBookValue'
    tools     = parseFloat Session.get 'toolBookValue'
    vehicles  = parseFloat Session.get 'vehicleBookValue'

    total = buildings + cellphones + computers + furniture + machinery + tools + vehicles
    total = total.toFixed(2)
    return total