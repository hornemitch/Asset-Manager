TabularTables = {}

TabularTables.BuildingImpairment = new (Tabular.Table)
  name: 'BuildingImpairment'
  collection: Building_Impairment
  info: false
  scrollCollapse: true
  scrollY: '70vh'
  order: [[0 , 'asc']]
  columns:[
    {
      class: 'col-md-2 td-words'
      data: 'dateOfImpair'
      title: 'Date'
    }
    {
      class: 'col-md-3 amoun-headings'
      data: 'value'
      title: 'Impairment Cost'
      tmpl: Meteor.isClient and Template.buildingImpairAmount
    }
    {
      class: 'col-md-6 td-words'
      data: 'description'
      title: 'Description'
    }
    {
      class: 'col-md-1 table-options'
      tmpl: Meteor.isClient and Template.buildingImpairDeleteIco
    }
  ]