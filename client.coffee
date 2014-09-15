if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_AND_EMAIL' }
  
  Template.takeawaysListItem.events
    'click .startFoodrun': (event) ->
      takeaway = share.Takeaways.findOne({_id: this._id})
      share.FoodRuns.insert
        takeaway: takeaway
        bespokenDishes: []
        organizer: Meteor.user()
        date: new Date()

  Template.foodrun.events
    'click .bespeakDish': (event, foodrunTemplate) ->
      this.bespokenBy = Meteor.user()
      share.FoodRuns.update({_id: foodrunTemplate.data.foodrun._id}, {$push: {bespokenDishes: this}})