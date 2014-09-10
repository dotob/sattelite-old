Router.map(function () {
  
  this.route('takeaways', {
    path: '/',
    template: 'takeaways',
    data: function () {
      return {
        takeaways: Takeaways.find({}),
        foodruns: FoodRuns.find({})
      } 
    }
  });

  this.route('takeaway', {
    path: 'takeaway/:_id',
    template: 'takeaway',
    data: function () {
      return {
        takeaway: Takeaways.findOne({_id: this.params._id})
      }
    }
  });

  this.route('foodrun', {
    path: 'foodrun/:_id',
    template: 'foodrun',
    data: function () {
      return {
        foodrun: FoodRuns.findOne({_id: this.params._id})
      }
    }
  });

});
