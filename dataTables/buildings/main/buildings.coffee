TabularTables = {}

TabularTables.Buildings = new (Tabular.Table)
  name: 'Buildings'
  collection: Buildings
  info: false
  scrollCollapse: true
  scrollY: '70vh'
  order: [[0 , 'asc']]
  stateSave : true
  columns:[
    {
      class: 'td-words'
      data: 'assetNumber'
      title: 'Asset Number'
    }
    {
      class: 'td-words'
      data: 'buildingName'
      title: 'Building Name'
    }
    {
      class: 'amount-headings'
      data: 'purchaseCost'
      title: 'Purchase Cost'
      tmpl: Meteor.isClient and Template.buildingPurchaseAmount
    }
    {
      class: 'amountHeadings'
      data: 'currentValue'
      title: 'Current Value'
      tmpl: Meteor.isClient and Template.buildingCurrentAmount
    }
    {
      class: 'col-md-2 table-options'
      tmpl: Meteor.isClient and Template.buildingIcons
    }
  ]