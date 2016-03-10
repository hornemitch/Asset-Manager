TabularTables = {}

TabularTables.BuildingRevaluation = new (Tabular.Table)
  name: 'BuildingRevaluation'
  collection: Building_Revaluation
  autoWidth : false
  info: false
  scrollCollapse: true
  scrollY: '70vh'
  order: [[0, 'asc']]
  stateSave : true
  columns:[
    {
      class: 'td-words'
      data : 'dateOfRevalue'
      title: 'Date of Revaluation'
    }
    {
      class: 'amount-headings'
      data : 'value'
      title: 'Current Value'
      tmpl : Meteor.isClient and Template.buildingRevalueAmount
    }
    {
      class: 'amount-headings'
      data : 'prevValue'
      title: 'Previous Value'
      tmpl : Meteor.isClient and Template.buildingRevaluePrevAmount
    }
    {
      class: 'table-options'
      tmpl : Meteor.isClient and Template.buildingRevalueDeleteIco
    }
  ]