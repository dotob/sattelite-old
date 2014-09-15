Template.takeawaysListItem.events({
  'click .startFoodrun': function (event) {
    var takeaway = Takeaways.findOne({_id: this._id});
    FoodRuns.insert({
      takeaway: takeaway, 
      bespokenDishes: [],
      organizer: Meteor.user()
    });
  }
});

