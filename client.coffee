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
        state: "ongoing"
      # send to everyone who likes this 
      for userId in takeaway.likes
        if userId != Meteor.userId() # do not send this mail to the current user
          Meteor.call('sendEmail',
                      userId,
                      "A new foodrun is started for #{takeaway.name}! Go for it!",
                      "You got this email because you liked #{takeaway.name}. If you dont anymore unlike it here: TODO")

    'click .like': (event) ->
      takeaway = share.Takeaways.findOne({_id: this._id})
      share.Takeaways.update({_id: takeaway._id}, {$push: {likes: Meteor.userId()}})

    'click .unLike': (event) ->
      takeaway = share.Takeaways.findOne({_id: this._id})
      share.Takeaways.update({_id: takeaway._id}, {$pull: {likes: Meteor.userId()}})

  Template.takeawaysListItem.helpers
    currentUserLikes: () ->
      takeaway = share.Takeaways.findOne({_id: this._id})
      _.contains takeaway.likes, Meteor.userId()


  Template.foodrun.events
    'click .bespeakDish': (event, foodrunTemplate) ->
      this.bespokenBy = Meteor.user()
      share.FoodRuns.update({_id: foodrunTemplate.data.foodrun._id}, {$push: {bespokenDishes: this}})
    'click .closeFoodrun': (event, foodrunTemplate) ->
      share.FoodRuns.update({_id: foodrunTemplate.data.foodrun._id}, {$set: {state: "closed"}})
    'click .reopenFoodrun': (event, foodrunTemplate) ->
      share.FoodRuns.update({_id: foodrunTemplate.data.foodrun._id}, {$set: {state: "ongoing"}})

  Template.foodrun.helpers
    isOpen: () ->
      @state == "ongoing"
    isOrganizer: () ->
      @organizer._id == Meteor.userId()
    bespokenDishesGrouped: () ->
      ret = []
      for id, dg of _.groupBy(@bespokenDishes, (d) -> d.order_number)
        ret.push
          order_number: if id? then id else "-"
          count: dg.length
          name: dg[0].name
      _.sortBy ret, (dg) -> dg.order_number
      
