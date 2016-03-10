TabularTables = {}

TabularTables.CellphoneMonths = new (Tabular.Table)
  name: 'CellphoneMonths'
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
      data: 'subscriptionTotal'
      title: 'Subscription Total'
      tmpl: Meteor.isClient and Template.cellphoneMonthSubscription
    }
    {
      class: 'col-md-3 amount-headings'
      data: 'totalBill'
      title: 'Total Bill'
      tmpl: Meteor.isClient and Template.cellphoneMonthSubTotal
    }
    {
      class: 'col-md-3 amount-headings'
      data: 'difference'
      title: 'Bill Difference'
      tmpl: Meteor.isClient and Template.cellphoneMonthSubDifference
    }
    {
      class: 'col-md-1 table-options'
      tmpl: Meteor.isClient and Template.cellphoneMonthSubIcons
    }
  ]
