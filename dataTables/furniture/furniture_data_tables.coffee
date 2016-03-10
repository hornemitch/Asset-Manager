TabularTables = {}

TabularTables.Furniture = new (Tabular.Table)
  name: 'Furniture'
  collection: Furniture
  info: false
  scrollCollapse : true
  scrollY : '60vh'
  order: [[0 , 'asc']]
  saveState: true
  columns:[
    {
      class : 'col-md-2 td-words'
      data: 'assetNumber'
      title: 'Asset Number'
    }
    {
      class : 'col-md-2 td-words'
      data: 'user'
      title: 'User'
    }
    {
      class : 'col-md-2 td-words'
      data: 'office'
      title: 'Office'
    }
    {
      class : 'col-md-2 amount-headings'
      data: 'costPrice'
      title: 'Purchase Cost'
      tmpl: Meteor.isClient and Template.furniturePurchase
    }
    {
      class : 'col-md-2 td-words'
      data: 'purchaseDate'
      title: 'Purchase Date'
    }
    {
      class: 'col-md-2 table-options'
      tmpl: Meteor.isClient and Template.furnitureIcons
    }
  ]