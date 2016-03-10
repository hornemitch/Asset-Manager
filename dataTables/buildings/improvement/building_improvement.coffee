TabularTables = {}

TabularTables.BuildingImprovement = new (Tabular.Table)
  name: 'BuildingImprovement'
  collection: Building_Improvement
  info: false
  scrollCollapse: true
  scrollY: '70vh'
  order: [[0 , 'asc']]
  columns:[
    {
      class: 'col-md-2 td-words'
      data: 'dateOfImprove'
      title: 'Date'
    }
    {
      class: 'col-md-3 amount-headings'
      data: 'value'
      title: 'Improvement Value'
      tmpl: Meteor.isClient and Template.buildingImproveAmount
    }
    {
      class: 'col-md-6 td-words'
      data: 'description'
      title: 'Description'
    }
    {
      class: 'col-md-1 table-options'
      tmpl: Meteor.isClient and Template.buildingImproveDeleteIco
    }
  ]