// routes

Router.map(function () {
  
  this.route('home', {
    path: '/',
    template: 'home',
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

// global onBeforeActions. use an object to store them.
var globalOnBeforeActions = {
    
    // redirect to the homepage if the current user is not logged in.
    loginRequired: function(pause) {
      if (!Meteor.userId()) {
        // render the home page template, but keep the url
        this.render('home');
        
        // pause rendering
        pause();
      }
    }
};

Router.onBeforeAction(globalOnBeforeActions.loginRequired, {
    except: ['home']
});
