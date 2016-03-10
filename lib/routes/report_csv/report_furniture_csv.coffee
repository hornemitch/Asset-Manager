Router.map ->
  @.route 'furniture_report_csv',
    path : '/furniture-report/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-furniture-' + dateName + '.csv'
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
      fileData += 'Asset Number,' + 'Office,'+ 'User,' + 'Status,' + 'Manufacturer,' + 'Model,' + 'Purchase Date,' + 'Purchase Price' +  '\r\n'

      furniture = Furniture.find()
      # * * Furniture Variables * *
      totalFurnitureCost = 0
      totalFurnitureCount = 0

      furniture.forEach (furniture) ->
        # * * Furniture Calculations* *
        totalFurnitureCost  += parseFloat furniture.costPrice
        totalFurnitureCount++

        furnitureCost = parseFloat furniture.costPrice
        furnitureCost = furnitureCost.toFixed(2)

        # * * Furniture CSV Insertion * *
        fileData += furniture.assetNumber + ',' + furniture.office + ',' + furniture.user + ',' + furniture.status + ',' + furniture.manufacturer + ',' + furniture.model + ',' + furniture.purchaseDate + ',' + furnitureCost + '\r\n'

      totalFurnitureCost = totalFurnitureCost.toFixed(2)

      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + totalFurnitureCount + ' Furniture,' + '-,-,-,-,-,' + totalFurnitureCost + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData