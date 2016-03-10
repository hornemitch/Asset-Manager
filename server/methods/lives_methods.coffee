###
    * * * * * * * * * * *
      Useful Lives Methods
    * * * * * * * * * * *
###

Meteor.methods
  # * * Building Methods * * #
  'startBuildingLife': ->
    UsefulLife.insert
      name         : 'Buildings'
      usefulLife   : '25 Years'
      depreciation : 100/25

  'updateBuildingLife': (life) ->
    life = parseFloat life
    depreciation = 100/life

    UsefulLife.update { name: 'Buildings' },
      $set:
        usefulLife   : life + ' Years'
        depreciation : depreciation

  # * * Cellphone Methods * * #
  'startCellphoneLife': ->
    UsefulLife.insert
      name         : 'Cellphones'
      usefulLife   : '2 Years'
      depreciation : 100/2

  'updateCellphoneLife': (life) ->
    life = parseFloat life
    depreciation = 100/life

    UsefulLife.update { name: 'Cellphones' },
      $set:
        usefulLife   : life + ' Years'
        depreciation : depreciation

  # * * Computer Methods * * #
  'startComputerLife': ->
    UsefulLife.insert
      name         : 'Computers'
      usefulLife   : '3 Years'
      depreciation : 100/3

  'updateComputerLife': (life) ->
    life = parseFloat life
    depreciation = 100/life

    UsefulLife.update { name: 'Computers' },
      $set:
        usefulLife   : life + ' Years'
        depreciation : depreciation

  # * * Furniture Methods * * #
  'startFurnitureLife': ->
    UsefulLife.insert
      name         : 'Furniture'
      usefulLife   : '6 Years'
      depreciation : 100/6

  'updateFurnitureLife': (life) ->
    life = parseFloat life
    depreciation = 100/life

    UsefulLife.update { name: 'Furniture' },
      $set:
        usefulLife   : life + ' Years'
        depreciation : depreciation

  # * * Small Assets Methods * * #
  'startSmallAssetsLife': ->
    UsefulLife.insert
      name         : 'SmallAssets'
      usefulLife   : '1 Year'
      depreciation : 100

  # * * Software Methods * * #
  'startSoftwareLife': ->
    UsefulLife.insert
      name         : 'Software'
      usefulLife   : '3 Years'
      depreciation : 100/3

  'updateSoftwareLife': (life) ->
    life = parseFloat life
    depreciation = 100/life

    UsefulLife.update { name: 'Software' },
      $set:
        usefulLife   : life + ' Years'
        depreciation : depreciation