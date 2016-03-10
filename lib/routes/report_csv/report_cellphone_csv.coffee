Router.map ->
  @.route 'cellphone_report_csv',
    path : '/cellphone-report/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-cell-phone-' + dateName + '.csv'
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
      fileData += 'Asset Number,' + 'Cell Phone Number,' + 'User,' + 'Status,' + 'Manufacturer,' + 'Model,' + 'Purchase Date,' + 'Purchase Cost' +  '\r\n'

      cellphones = Cellphones.find()
      # * * Cellphone Variables * *
      totalCellphoneCost = 0
      count = 0

      cellphones.forEach (cellphone) ->
        # * * Cellphone Calculations* *
        totalCellphoneCost  += parseFloat cellphone.costPrice
        count++

        cellCost = parseFloat cellphone.costPrice
        cellCost = cellCost.toFixed(2)

        # * * Cellphone CSV Insertion * *
        fileData += cellphone.assetNumber + ',' + cellphone.number + ',' + cellphone.user + ',' + cellphone.status + ',' + cellphone.manufacturer + ',' + cellphone.model + ',' + cellphone.purchaseDate + ',' + cellCost + '\r\n'

      totalCellphoneCost = totalCellphoneCost.toFixed(2)

      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + count + ' Cell Phones,' + '-,-,-,-,-,' + totalCellphoneCost + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData