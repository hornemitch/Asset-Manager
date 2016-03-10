TabularTables = {}

TabularTables.Tools = new (Tabular.Table)
  name: 'Tools'
  collection: Tools
  info: false
  scrollCollapse : true
  scrollY : '60vh'
  order: [[0 , 'asc']]
  saveState:true
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
      tmpl: Meteor.isClient and Template.toolsPurchase
    }
    {
      class : 'col-md-2 td-words'
      data: 'manufacturer'
      title: 'Manufacturer'
    }
    {
      class : 'col-md-2 td-words'
      data: 'model'
      title: 'Model'
    }
    {
      class: 'col-md-2 table-options'
      tmpl: Meteor.isClient and Template.toolsIcons
    }
  ]