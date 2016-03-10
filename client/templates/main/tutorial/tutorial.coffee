Template.tutorial.onCreated ->
  mainDoc = $('html')
  mainDoc.removeClass()
  mainDoc.addClass 'tutorial'

  body = $('.body-container')
  body.css 'min-height', 'auto'
  body.css 'padding', '2% 5%'

Template.tutorial.onDestroyed ->
  body = $('.body-container')
  body.css 'min-height', '100vh'
  body.css 'padding', '1% 5%'