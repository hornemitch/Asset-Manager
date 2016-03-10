TabularTables = {}

TabularTables.Computers = new (Tabular.Table)
  name: 'Computers'
  collection: Computers
  info: false
  scrollCollapse: true
  scrollY: '60vh'
  order: [[0 , 'asc']]
  saveState: true
  columns:[
    {
      class : 'td-words'
      data: 'assetNumber'
      title: 'Asset Number'
    }
    {
      class : 'td-words'
      data: 'serialNumber'
      title: 'Serial Number'
    }
    {
      class : 'amount-headings'
      data: 'costPrice'
      title: 'Purchase Cost'
      tmpl: Meteor.isClient and Template.computerPurchase
    }
    {
      class : 'td-words'
      data: 'purchaseDate'
      title: 'Purchase Date'
    }
    {
      class : 'td-words'
      data: 'user'
      title: 'Computer User'
    }
    {
      class: 'col-md-2 table-options'
      tmpl: Meteor.isClient and Template.computerIcons
    }
  ]