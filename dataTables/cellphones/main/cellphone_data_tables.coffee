TabularTables = {}

TabularTables.Cellphones = new (Tabular.Table)
  name: 'Cellphones'
  collection: Cellphones
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
      class: 'amount-headings'
      data: 'costPrice'
      title: 'Purchase Cost'
      tmpl: Meteor.isClient and Template.cellphonePurchase
    }
    {
      class: 'td-words'
      data: 'number'
      title: 'Cell Number'
      tmpl: Meteor.isClient and Template.cellphoneNumber
    }
    {
      class: 'td-words'
      data: 'purchaseDate'
      title: 'Purchase Date'
    }
    {
      class: 'td-words'
      data: 'user'
      title: 'Cellphone User'
    }
    {
      class: 'col-md-2 table-options'
      tmpl: Meteor.isClient and Template.cellphoneIcon
    }
  ]
