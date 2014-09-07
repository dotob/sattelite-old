if (Meteor.isClient) {

  Template.takeaways.helpers({
    takeaways: function () {
      return Takeaways.find({});
    },
    foodruns: function () {
      return FoodRuns.find({});
    }
  });

  Template.takeaway.helpers({
    log: function () {
      console.log("Context here is:");
      console.log(this);
    }
  });

  Template.takeaway.events({
    'click .template_name': function (event) {
      var takeaway = Takeaways.findOne({_id: this._id});
      FoodRuns.insert({takeaway: takeaway});
    }
  });

}
