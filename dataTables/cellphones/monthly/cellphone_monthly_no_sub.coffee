TabularTables = {}

TabularTables.CellphoneMonthsNoSub = new (Tabular.Table)
  name: 'CellphoneMonthsNoSub'
  collection: Cellphone_Monthly
  info: false
  scrollCollapse: true
  scrollY: '70vh'
  order: [[0 , 'asc']]
  saveState: true
  columns:[
    {
      class: 'col-md-2 td-words'
      data: 'month'
      title: 'Month'
    }
    {
      class: 'col-md-3 amount-headings'
      data: 'airtimeCosts'
      title: 'Airtime Costs'
      tmpl: Meteor.isClient and Template.cellphoneMonthNoSubAirtime
    }
    {
      class: 'col-md-3 amount-headings'
      data: 'dataCosts'
      title: 'Data Costs'
      tmpl: Meteor.isClient and Template.cellphoneMonthNoSubData
    }
    {
      class: 'col-md-3 amount-headings'
      data: 'totalBill'
      title: 'Total Bill'
      tmpl: Meteor.isClient and Template.cellphoneMonthNoSubTotal
    }
    {
      class: 'col-md-1 table-options'
      tmpl: Meteor.isClient and Template.cellphoneMonthNoSubIcons
    }
  ]


