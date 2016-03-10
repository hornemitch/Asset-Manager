Router.map ->
  @.route 'buildings_report_csv',
    path : '/building-report/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-buildings-' + dateName + '.csv'
      fileData = ''
      headers =
        'Content-type': 'text/csv'
        'Content-Disposition': 'attachment; filename=' + filename

      ###
          * * * * * * * * * * * * *
            Remake Report in CSV
          * * * * * * * * * * * * *
      ###

      # * * Heading Insertion * *
      fileData += 'Asset Number,' + 'Building Name,' + 'Status,' + 'Purchase Date,' + 'Purchase Cost,' + 'Current Value' +  '\r\n'

      buildings = Buildings.find()
      # * * Building Variables * *
      totalBuildingCost = 0
      totalBuildingValue = 0
      count = 0

      buildings.forEach (building) ->
        # * * Building Calculations* *
        totalBuildingCost  += parseFloat building.purchaseCost
        totalBuildingValue += parseFloat building.currentValue
        count++

        buildingCost = parseFloat building.purchaseCost
        buildingCost = buildingCost.toFixed(2)
        buildingCurr = parseFloat building.currentValue
        buildingCurr = buildingCurr.toFixed(2)

        # * * Building CSV Insertion * *
        fileData += building.assetNumber + ',' + building.buildingName + ',' + building.status + ',' + building.purchaseDate + ',' + buildingCost + ',' + buildingCurr + '\r\n'


      totalBuildingCost  = totalBuildingCost.toFixed(2)
      totalBuildingValue = totalBuildingValue.toFixed(2)
      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + count + ' buildings,' + '-,-,' + totalBuildingCost + ',' + totalBuildingValue + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData