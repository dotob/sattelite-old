if (Meteor.isClient) {
  Template.takeaways.takeaways = function () {
    return Takeaways.find({});
  }  

  Template.takeaways.foodruns = function () {
    return FoodRuns.find({});
  }

  Template.takeaways.events({
    'click .template_name': function (event) {
      FoodRuns.insert({});
    }
  })
}
