if (Meteor.isClient) {
  Template.takeaways.takeaways = function (){
    return Takeaways.find({});
  }  

  Template.takeaways.events({
    'click .template_name': function (event) {
      console.log("worky");
    }
  })
}
