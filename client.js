if (Meteor.isClient) {

  Template.takeaways.helpers({
    takeaways: function () {
      return Takeaways.find({});
    },
    foodruns: function () {
      return FoodRuns.find({});
    }
  });

  Template.takeaway.events({
    'click .template_name': function (event) {
      var takeaway = Takeaways.findOne({_id: this._id});
      FoodRuns.insert({takeaway: takeaway});
    }
  });

}
