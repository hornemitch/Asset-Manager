Router.map ->
  @.route 'vehicle_report_csv',
    path : '/vehicle-report/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-vehicles-' + dateName + '.csv'
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
      fileData += 'Asset Number,' + 'Vehicle Licence,'+ 'Category,' + 'Status,' + 'Manufacturer,' + 'Model,' + 'Purchase Date,' + 'Purchase Price' +  '\r\n'

      vehicles = Vehicles.find()
      # * * Vehicles Variables * *
      totalVehicleCost = 0
      totalVehicleCount = 0

      vehicles.forEach (vehicle) ->
        # * * Vehicles Calculations* *
        totalVehicleCost  += parseFloat vehicle.costPrice
        totalVehicleCount++

        vehiclecat = Vehicle_Category.findOne(vehicle.category)

        vehicleCost = parseFloat vehicle.costPrice
        vehicleCost = vehicleCost.toFixed(2)

        # * * Vehicles CSV Insertion * *
        fileData += vehicle.assetNumber + ',' + vehicle.licencePlate + ',' + vehiclecat.name + ',' + vehicle.status + ',' + vehicle.manufacturer + ',' + vehicle.model + ',' + vehicle.purchaseDate + ',' + vehicleCost + '\r\n'

      totalVehicleCost = totalVehicleCost.toFixed(2)

      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + totalVehicleCount + ' Vehicles,' + '-,-,-,-,-,' + totalVehicleCost + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData