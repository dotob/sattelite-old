// hooks 

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
