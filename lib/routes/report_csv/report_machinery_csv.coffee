Router.map ->
  @.route 'machinery_report_csv',
    path : '/machinery-report/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-machinery-' + dateName + '.csv'
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
      fileData += 'Asset Number,' + 'Serial Number,'+ 'Category,' + 'Status,' + 'Manufacturer,' + 'Model,' + 'Purchase Date,' + 'Purchase Price' +  '\r\n'

      machinery = Machinery.find()
      # * * Furniture Variables * *
      totalMachineryCost = 0
      totalMachineryCount = 0

      machinery.forEach (machine) ->
        # * * Furniture Calculations* *
        totalMachineryCost  += parseFloat machine.costPrice
        totalMachineryCount++

        machinecat = Machine_Category.findOne(machine.category)

        machineryCost = parseFloat machine.costPrice
        machineryCost = machineryCost.toFixed(2)

        # * * Furniture CSV Insertion * *
        fileData += machine.assetNumber + ',' + machine.serialNumber + ',' + machinecat.name + ',' + machine.status + ',' + machine.manufacturer + ',' + machine.model + ',' + machine.purchaseDate + ',' + machineryCost + '\r\n'

      totalMachineryCost = totalMachineryCost.toFixed(2)

      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + totalMachineryCount + ' Machinery,' + '-,-,-,-,-,' + totalMachineryCost + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData