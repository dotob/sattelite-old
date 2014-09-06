if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_AND_EMAIL' }
  
  takeaway_data = [
      {
        name: "takeaway1"
      }
      {
        name: "takeaway2"
      }
  
  ]

  Template.home.helpers
    takeaways: takeaway_data

  Template.dishes.dishes = ->
    share.Dishes.find {}

  Template.takeaways.takeaways = ->
    dishes = share.Dishes.find({}).fetch()
    takeaways_grouped = _.groupBy dishes, (d) ->
      d.takeaway.id
    _.map _.values(takeaways_grouped), (g) ->
      _.first(g).takeaway
