Router.map ->
  @.route 'computer_report_csv',
    path : '/computer-report/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-computer-' + dateName + '.csv'
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
      fileData += 'Asset Number,' + 'Serial Number,'+ 'User,' + 'Status,' + 'Manufacturer,' + 'Model,' + 'Purchase Date,' + 'Purchase Cost' +  '\r\n'

      computers = Computers.find()
      # * * Computer Variables * *
      totalComputerCost = 0
      totalComputerCount = 0

      computers.forEach (computer) ->
        # * * Computer Calculations* *
        totalComputerCost  += parseFloat computer.costPrice
        totalComputerCount++

        computerCost = parseFloat computer.costPrice
        computerCost = computerCost.toFixed(2)

        # * * Computer CSV Insertion * *
        fileData += computer.assetNumber + ',' + computer.serialNumber + ',' + computer.user + ',' + computer.status + ',' + computer.manufacturer + ',' + computer.model + ',' + computer.purchaseDate + ',' + computerCost + '\r\n'

      totalComputerCost = totalComputerCost.toFixed(2)

      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + totalComputerCount + ' Computers,' + '-,-,-,-,-,' + totalComputerCost + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData