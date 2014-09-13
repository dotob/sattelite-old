if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_AND_EMAIL' }
  
  Template.takeawaysListItem.events
    'click .startFoodrun': (event) =>
      takeaway = Takeaways.findOne({_id: this._id})
      FoodRuns.insert
        takeaway: takeaway
        bespokenDishes: []
        organizer: Meteor.user()

  Template.foodrun.events
    'click .bespeakDish': (event, foodrunTemplate) =>
      this.bespokenBy = Meteor.user()
      FoodRuns.update({_id: foodrunTemplate.data.foodrun._id}, {$push: {bespokenDishes: this}})
