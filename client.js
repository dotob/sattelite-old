if (Meteor.isClient) {

  Template.takeaway.events({
    'click .template_name': function (event) {
      var takeaway = Takeaways.findOne({_id: this._id});
      FoodRuns.insert({takeaway: takeaway});
    }
  });

}
