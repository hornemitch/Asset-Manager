Router.map ->
  @.route 'tool_report_csv',
    path : '/tool-report/csv'
    where: 'server'
    action: ->
      date = new Date()
      dateName = (date.getMonth()+1) + '-' +  (date.getFullYear())
      filename = 'Report-overview-tools-' + dateName + '.csv'
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

      tools = Tools.find()
      # * * Furniture Variables * *
      totalToolCost = 0
      totalToolCount = 0

      tools.forEach (tool) ->
        # * * Furniture Calculations* *
        totalToolCost  += parseFloat tool.costPrice
        totalToolCount++

        toolcat = Tool_Category.findOne(tool.category)

        toolCost = parseFloat tool.costPrice
        toolCost = toolCost.toFixed(2)

        # * * Furniture CSV Insertion * *
        fileData += tool.assetNumber + ',' + tool.serialNumber + ',' + toolcat.name + ',' + tool.status + ',' + tool.manufacturer + ',' + tool.model + ',' + tool.purchaseDate + ',' + toolCost + '\r\n'

      totalToolCost = totalToolCost.toFixed(2)

      # * * Totals CSV Insertion * *
      fileData += 'Totals,' + totalToolCount + ' Tools,' + '-,-,-,-,-,' + totalToolCost + '\r\n'

      @response.writeHead 200, headers
      @response.end fileData