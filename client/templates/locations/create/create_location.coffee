Template.create_location.onRendered ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'locations'

Template.create_location.events
  'submit .addLocation': (event) ->
    event.preventDefault()

    siteName        = event.target.siteName.value
    country         = event.target.country.value
    province        = event.target.province.value
    city            = event.target.city.value
    postalCode      = event.target.postalCode.value
    streetAndNumber = event.target.streetAndNumber.value

    Meteor.call "addLocation", siteName, country, province, city, postalCode, streetAndNumber
    Router.go 'locations'