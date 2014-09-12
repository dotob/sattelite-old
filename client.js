if (Meteor.isClient) {

  Template.takeawaysListItem.events({
    'click .startFoodrun': function (event) {
      var takeaway = Takeaways.findOne({_id: this._id});
      FoodRuns.insert({
        takeaway: takeaway, 
        bespokenDishes: []
      });
    }
  });

  Template.foodrun.events({
    'click .bespeakDish': function (event, foodrunTemplate) {
      FoodRuns.update({_id: foodrunTemplate.data.foodrun._id}, {$push: {bespokenDishes: this}});
    }
  });
}
