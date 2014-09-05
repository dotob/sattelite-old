if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_AND_EMAIL' }
  
  Template.dishes.dishes = ->
    share.Dishes.find {}

  Template.takeaways.takeaways = ->
    dishes = share.Dishes.find({}).fetch()
    takeaways_grouped = _.groupBy dishes, (d) ->
      d.menu.id
    _.map _.values(takeaways_grouped), (g) ->
      _.first(g).menu
