Template.foodrun.events({
  'click .bespeakDish': function (event, foodrunTemplate) {
    this.bespokenBy = Meteor.user();
    FoodRuns.update({_id: foodrunTemplate.data.foodrun._id}, {$push: {bespokenDishes: this}});
  }
});
