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
    template: '',
    data: function () {
      return {
        takeaway: Takeaways.findOne({_id: this.params._id})
      }
    }
  });
});
