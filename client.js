if (Meteor.isClient) {
  Template.takeaways.takeaways = function (){
    return Takeaways.find({});
  }  
}
