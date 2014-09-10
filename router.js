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
});
