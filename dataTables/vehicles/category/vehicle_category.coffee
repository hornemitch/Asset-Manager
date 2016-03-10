TabularTables = {}

TabularTables.Vehicle_Category = new (Tabular.Table)
  name: 'Vehicle_Category'
  collection: Vehicle_Category
  info: false
  scrollCollapse: true
  scrollY: '60vh'
  order: [[0 , 'asc']]
  saveState: true
  columns:[
    {
      class: 'td-words'
      data: 'name'
      title: 'Category Name'
    }
    {
      class: 'td-words'
      data: 'usefulLife'
      title: 'Useful Life'
      tmpl: Meteor.isClient and Template.vehicleCategoryUsefulLife
    }
    {
      class: 'td-words'
      data: 'depreciation'
      title: 'Depreciation Rate'
      tmpl: Meteor.isClient and Template.vehicleCategoryDepreciation
    }
    {
      class: 'col-md-1 table-options'
      tmpl: Meteor.isClient and Template.vehicleCategoryUpdateIco
    }
  ]