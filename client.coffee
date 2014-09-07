if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_AND_EMAIL' }
  
  Template.home.helpers
    takeaways: ->
      share.Takeaways.find {}

  Template.dishes.dishes = ->
    share.Dishes.find {}

