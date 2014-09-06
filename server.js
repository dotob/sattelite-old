if (Meteor.isServer) {
  Meteor.startup(function () {
    if(Takeaways.find().count() === 0) {
      var takeaways = ["Toni",
                       "Giovanni"]
      for (var i = takeaways.length - 1; i >= 0; i--) {
        Takeaways.insert({name: takeaways[i]});
      };
    }
  })
};
