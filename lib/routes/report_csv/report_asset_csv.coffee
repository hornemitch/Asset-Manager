Router.map ->
  @.route 'overview_cost_csv',
    path : '/overview-asset/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-asset-' + dateName + '.csv'
      fileData = ''
      headers =
        'Content-type': 'text/csv'
        'Content-Disposition': 'attachment; filename=' + filename

      ###
          * * * * * * * * * * * * *
            Remake Report in CSV
          * * * * * * * * * * * * *
      ###

      ###
          * * * * * * *
            Buildings
          * * * * * * *
      ###

      buildings = Buildings.find()
      totalBuildings = 0
      totalBuildingCost = 0
      buildingRate = UsefulLife.findOne({name:'Buildings'}).depreciation
      totalBuildingDepreciation = 0

      buildings.forEach (building) ->
        totalBuildings++
        totalBuildingCost += parseFloat building.purchaseCost

        if building.type == true
          buyDate  = building.purchaseDate
          split    = buyDate.split('-')

          oldMonth = split[1]
          oldYear  = split[2]

          nowDate       = new Date()
          newMonth      = nowDate.getMonth() + 1
          newYear       = nowDate.getFullYear()

          months = (newYear - oldYear)*12 + (newMonth - oldMonth)
          depreciation =(parseFloat building.purchaseCost * (buildingRate/100/12 * months))

          totalBuildingDepreciation += depreciation

      totalBuildingBookValue = totalBuildingCost - totalBuildingDepreciation

      ###
          * * * * * * * *
            Cellphones
          * * * * * * * *
      ###

      cellphones = Cellphones.find()
      # * * Cellphone Variables * *
      totalCellphones = 0
      totalCellphoneCost = 0
      cellphoneRate = UsefulLife.findOne({name:'Cellphones'}).depreciation
      totalCellphoneDepreciation = 0

      cellphones.forEach (cellphone) ->
        # * * Cellphone Calculations* *
        totalCellphones++
        totalCellphoneCost += parseFloat cellphone.costPrice

        buyDate  = cellphone.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate  = new Date()
        newMonth = nowDate.getMonth() + 1
        newYear  = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        depreciation =(parseFloat cellphone.costPrice * (parseFloat cellphoneRate/100/12 * months))

        totalCellphoneDepreciation += depreciation

      totalCellphoneBookValue = totalCellphoneCost - totalCellphoneDepreciation

      ###
          * * * * * * *
            Computers
          * * * * * * *
      ###

      computers = Computers.find()
      # * * Computer Variables * *
      totalComputers = 0
      totalComputerCost = 0
      computerRate = UsefulLife.findOne({name:'Computers'}).depreciation
      totalComputerDepreciation = 0

      computers.forEach (computer) ->
        # * * Computer Calculations* *
        totalComputers++
        totalComputerCost += parseFloat computer.costPrice

        buyDate  = computer.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate  = new Date()
        newMonth = nowDate.getMonth() + 1
        newYear  = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        depreciation =(parseFloat computer.costPrice * (parseFloat computerRate/100/12 * months))
        totalComputerDepreciation += depreciation

      totalComputerBookValue = totalComputerCost - totalComputerDepreciation

      ###
          * * * * * * *
            Furniture
          * * * * * * *
      ###

      furniture = Furniture.find()
      # * * Furniture Variables * *
      totalFurniture = 0
      totalFurnitureCost = 0
      furnitureRate = UsefulLife.findOne({name:'Furniture'}).depreciation
      totalFurnitureDepreciation = 0

      furniture.forEach (furniture) ->
        # * * Furniture Calculations* *
        totalFurniture++
        totalFurnitureCost += parseFloat furniture.costPrice

        buyDate  = furniture.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate  = new Date()
        newMonth = nowDate.getMonth() + 1
        newYear  = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        depreciation =(parseFloat furniture.costPrice * (parseFloat furnitureRate/100/12 * months))
        totalFurnitureDepreciation += depreciation

      totalFurnitureBookValue = totalFurnitureCost - totalFurnitureDepreciation

      ###
          * * * * * * *
            Machinery
          * * * * * * *
      ###

      machinery = Machinery.find()
      # * * Machinery Variables * *
      totalMachinery = 0
      totalMachineryCost = 0
      totalMachineryDepreciation = 0

      machinery.forEach (machinery) ->
        # * * Machinery Calculations* *
        machineCategory =  machinery.category
        category = Machine_Category.findOne(machineCategory)
        category_depreciation = category.depreciation

        totalMachinery++
        totalMachineryCost += parseFloat machinery.costPrice

        buyDate  = machinery.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate  = new Date()
        newMonth = nowDate.getMonth() + 1
        newYear  = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        depreciation =(parseFloat machinery.costPrice * (parseFloat category_depreciation/100/12 * months))
        totalMachineryDepreciation += depreciation

      totalMachineryBookValue = totalMachineryCost - totalMachineryDepreciation

      ###
          * * * * *
            Tools
          * * * * *
      ###

      tools = Tools.find()
      # * * Tools Variables * *
      totalTools = 0
      totalToolsCost = 0
      totalToolsDepreciation = 0

      tools.forEach (tool) ->
        # * * Tools Calculations* *
        toolCategory =  tool.category
        category = Tool_Category.findOne(toolCategory)
        category_depreciation = category.depreciation

        totalTools++
        totalToolsCost += parseFloat tool.costPrice

        buyDate  = tool.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate  = new Date()
        newMonth = nowDate.getMonth() + 1
        newYear  = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        depreciation =(parseFloat tool.costPrice * (parseFloat category_depreciation/100/12 * months))
        totalToolsDepreciation += depreciation

      totalToolsBookValue = totalToolsCost - totalToolsDepreciation

      ###
          * * * * * * *
            Vehicles
          * * * * * * *
      ###

      vehicles = Vehicles.find()
      # * * Vehicles Variables * *
      totalVehicles = 0
      totalVehiclesCost = 0
      totalVehiclesDepreciation = 0

      vehicles.forEach (vehicle) ->
        # * * Vehicles Calculations* *
        vehicleCategory =  vehicle.category
        category = Vehicle_Category.findOne(vehicleCategory)
        category_depreciation = category.depreciation

        totalVehicles++
        totalVehiclesCost += parseFloat vehicle.costPrice

        buyDate  = vehicle.purchaseDate
        split    = buyDate.split('-')

        oldMonth = split[1]
        oldYear  = split[2]

        nowDate  = new Date()
        newMonth = nowDate.getMonth() + 1
        newYear  = nowDate.getFullYear()

        months = (newYear - oldYear)*12 + (newMonth - oldMonth)
        cp = parseFloat vehicle.costPrice
        dr = parseFloat category_depreciation
        depreciation =(cp * (dr/100/12 * months))

        totalVehiclesDepreciation += depreciation

      totalVehiclesBookValue = totalVehiclesCost - totalVehiclesDepreciation

      ###
          * * * * * *
            Totals
          * * * * * *
      ###

      totalCosts = totalBuildingCost + totalCellphoneCost + totalComputerCost + totalFurnitureCost + totalMachineryCost + totalToolsCost + totalVehiclesCost
      totalDeps  = totalBuildingDepreciation + totalCellphoneDepreciation + totalComputerDepreciation + totalFurnitureDepreciation + totalMachineryDepreciation + totalToolsDepreciation + totalVehiclesDepreciation
      totalBooks = totalCellphoneBookValue + totalComputerBookValue + totalFurnitureBookValue + totalMachineryBookValue + totalToolsBookValue + totalVehiclesBookValue

      ###
          * * * * * * * *
            CSV Building
          * * * * * * * *
      ###

      # * * Heading Insertion * *
      fileData += 'Asset Type,' + 'Quantity,' + 'Total Cost,' + 'Acc.Depreciation,' + 'Book Values' + '\r\n'

      # * * Building Variable Fixing * *
      totalBuildingCost         = totalBuildingCost.toFixed(2)
      totalBuildingDepreciation = totalBuildingDepreciation.toFixed(2)
      totalBuildingBookValue    = totalBuildingBookValue.toFixed(2)
      # * * Building CSV Insertion * *
      fileData += 'Buildings,' + totalBuildings + ',' + totalBuildingCost + ',' + totalBuildingDepreciation + ',' + totalBuildingBookValue + '' + '\r\n'

      # * * Cell phone Variable Fixing * *
      totalCellphones            = totalCellphones.toFixed(2)
      totalCellphoneDepreciation = totalCellphoneDepreciation.toFixed(2)
      totalCellphoneBookValue    = totalCellphoneBookValue.toFixed(2)
      # * * Cellphone CSV Insertion * *
      fileData += 'Cell phones,' + totalCellphones + ',' + totalCellphoneCost + ',' + totalCellphoneDepreciation + ',' + totalCellphoneBookValue + '\r\n'

      # * * Computer Variable Fixing * *
      totalComputerCost         = totalComputerCost.toFixed(2)
      totalComputerDepreciation = totalComputerDepreciation.toFixed(2)
      totalComputerBookValue    = totalComputerBookValue.toFixed(2)
      # * * Computer CSV Insertion * *
      fileData += 'Computers,' + totalComputers + ',' + totalComputerCost + ',' + totalComputerDepreciation + ',' + totalComputerBookValue + '\r\n'

      # * * Furniture Variable Fixing * *
      totalFurnitureCost         = totalFurnitureCost.toFixed(2)
      totalFurnitureDepreciation = totalFurnitureDepreciation.toFixed(2)
      totalFurnitureBookValue    = totalFurnitureBookValue.toFixed(2)
      # * * Furniture CSV Insertion * *
      fileData += 'Furniture,' + totalFurniture + ',' + totalFurnitureCost + ',' + totalFurnitureDepreciation + ',' + totalFurnitureBookValue + '\r\n'

      # * * Machinery Variable Fixing * *
      totalMachineryCost         = totalMachineryCost.toFixed(2)
      totalMachineryDepreciation = totalMachineryDepreciation.toFixed(2)
      totalMachineryBookValue    = totalMachineryBookValue.toFixed(2)
      # * * Machinery CSV Insertion * *
      fileData += 'Machinery,' + totalMachinery + ',' + totalMachineryCost + ',' + totalMachineryDepreciation + ',' + totalMachineryBookValue + '\r\n'

      # * * Tools Variable Fixing * *
      totalToolsCost         = totalToolsCost.toFixed(2)
      totalToolsDepreciation = totalToolsDepreciation.toFixed(2)
      totalToolsBookValue    = totalToolsBookValue.toFixed(2)
      # * * Tools CSV Insertion * *
      fileData += 'Tools,' + totalTools + ',' + totalToolsCost + ',' + totalToolsDepreciation + ',' + totalToolsBookValue + '\r\n'

      # * * Vehicles Variable Fixing * *
      totalVehiclesCost         = totalVehiclesCost.toFixed(2)
      totalVehiclesDepreciation = totalVehiclesDepreciation.toFixed(2)
      totalVehiclesBookValue    = totalVehiclesBookValue.toFixed(2)
      # * * Vehicles CSV Insertion * *
      fileData += 'Vehicles,' + totalVehicles + ',' + totalVehiclesCost + ',' + totalVehiclesDepreciation + ',' + totalVehiclesBookValue + '\r\n'

      # * * Totals Variable Fixing * *
      totalCosts = totalCosts.toFixed(2)
      totalDeps  = totalDeps.toFixed(2)
      totalBooks = totalBooks.toFixed(2)
      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + '-,' + totalCosts + ',' + totalDeps + ',' + totalBooks + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData