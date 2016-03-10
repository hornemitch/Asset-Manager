TabularTables = {}

TabularTables.MachineMonthly = new (Tabular.Table)
  name: 'MachineMonthly'
  collection: Machine_Monthly
  info: false
  scrollCollapse : true
  scrollY : '60vh'
  order: [[1 , 'asc']]
  saveState: true
  columns:[
    {
      class:'col-md-3 td-words'
      data: 'month'
      title: 'Month'
    }
    {
      class:'col-md-3 amount-headings'
      data: 'maintenance'
      title: 'Maintenance Cost'
      tmpl: Meteor.isClient and Template.machineryMonthlyMaintenance
    }
    {
      class:'col-md-3 amount-headings'
      data: 'revaluation'
      title: 'Revaluation Value'
      tmpl: Meteor.isClient and Template.machineryMonthlyRevalue
    }
    {
      class: 'col-md-1 table-options'
      tmpl: Meteor.isClient and Template.machineryMonthlyDeleteIco
    }
  ]