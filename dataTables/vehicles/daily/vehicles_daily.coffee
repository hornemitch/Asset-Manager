TabularTables = {}

TabularTables.VehicleDaily = new (Tabular.Table)
  name: 'VehicleDaily'
  collection: Vehicle_Daily
  info: false
  scrollCollapse : true
  scrollY : '60vh'
  order: [[0 , 'asc']]
  saveState: true
  columns:[
    {
      class : 'col-md-2 td-words'
      data: 'date'
      title: 'Date'
    }
    {
      class : 'col-md-2 amount-headings'
      data: 'currentOdometer'
      title: 'Last Odometer Reading'
      tmpl: Meteor.isClient and Template.vehicleDailyLastOdo
    }
    {
      class : 'col-md-2 amount-headings'
      data: 'odometerReading'
      title: 'Odometer Reading'
      tmpl: Meteor.isClient and Template.vehicleDailyCurrOdo
    }
    {
      class : 'col-md-2 amount-headings'
      data: 'distanceTraveled'
      title: 'Distance Traveled'
      tmpl: Meteor.isClient and Template.vehicleDailyDistance
    }
    {
      class : 'col-md-3 td-words'
      data: 'comment'
      title: 'Comment'
    }
    {
      class: 'col-md-1 table-options'
      tmpl: Meteor.isClient and Template.vehicleDailyDeleteIco
    }
  ]