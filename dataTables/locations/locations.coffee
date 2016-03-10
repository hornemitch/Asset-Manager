TabularTables = {}

TabularTables.Locations = new (Tabular.Table)
  name: 'Locations'
  collection: Locations
  info: false
  scrollCollapse: true
  scrollY: '60vh'
  order: [[0 , 'asc']]
  saveState: true
  columns:[
    {
      class : 'col-md-2 td-words'
      data: 'siteName'
      title: 'Site Name'
    }
    {
      class : 'col-md-2 td-words'
      data: 'streetAndNumber'
      title: 'Street'
    }
    {
      class : 'col-md-2 td-words'
      data: 'city'
      title: 'City'
    }
    {
      class : 'col-md-2 td-words'
      data: 'postalCode'
      title: 'Postal Code'
    }
    {
      class : 'col-md-2 td-words'
      data: 'province'
      title: 'Province'
    }
    {
      class : 'col-md-2 td-words'
      data: 'country'
      title: 'Country'
    }
  ]