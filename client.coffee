if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_AND_EMAIL' }
  
  Template.home.helpers
    takeaways: ->
      dishes = share.Dishes.find({}).fetch()
      takeaways_grouped = _.groupBy dishes, (d) ->
        d.takeaway.id
      _.map _.values(takeaways_grouped), (g) ->
        _.first(g).takeaway

  Template.dishes.dishes = ->
    share.Dishes.find {}

