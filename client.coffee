if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_ONLY' }
  
  Template.dishes.dishes = ->
    share.Dishes.find {}

  Template.deliveries.deliveries = ->
    dishes = share.Dishes.find({}).fetch()
    deliveries_grouped = _.groupBy dishes, (d) ->
      d.menu.id
    _.map _.values(deliveries_grouped), (g) ->
      _.first(g).menu
