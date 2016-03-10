TabularTables = {}

TabularTables.ComputerSoftware = new (Tabular.Table)
  name: 'ComputerSoftware'
  collection: Computer_Software
  info: false
  scrollCollapse: true
  scrollY: '60vh'
  order: [[0 , 'asc']]
  stateSave: true
  columns:[
    {
      class : 'td-words'
      data: 'name'
      title: 'Software Name'
    }
    {
      class : 'td-words'
      data: 'installed'
      title: 'Installed'
    }
    {
      class : 'td-words'
      data: 'licenceKey'
      title: 'licence Key'
    }
    {
      class : 'td-words'
      data: 'licenceRenewalDate'
      title: 'Renewal Date'
    }
    {
      class : 'amount-headings'
      data: 'purchaseCost'
      title: 'Purchase Cost'
      tmpl: Meteor.isClient and Template.computerSoftwarePurchase
    }
    {
      class: 'col-md-2 table-options'
      tmpl: Meteor.isClient and Template.computerSoftwareIcons
    }
  ]