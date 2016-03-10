TabularTables = {}

TabularTables.Machinery = new (Tabular.Table)
  name: 'Machinery'
  collection: Machinery
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
      data: 'serialNumber'
      title: 'Serial Number'
    }
    {
      class : 'col-md-2 amount-headings'
      data: 'costPrice'
      title: 'Purchase Cost'
      tmpl: Meteor.isClient and Template.machineryPurchase
    }
    {
      class : 'col-md-2 td-words'
      data: 'purchaseDate'
      title: 'Purchase Date'
    }
    {
      class : 'col-md-2 td-words'
      data: 'model'
      title: 'Model'
    }
    {
      class: 'col-md-2 table-options'
      tmpl: Meteor.isClient and Template.machineryIcons
    }
  ]