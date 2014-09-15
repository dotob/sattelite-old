Router.map ->
  @route "home",
    path: "/"
    template: "home"
    data: ->
      takeaways: share.Takeaways.find({})
      foodruns: share.FoodRuns.find({state: "ongoing"})

  @route "takeaway",
    path: "takeaway/:_id"
    template: "takeaway"
    data: ->
      takeaway: share.Takeaways.findOne(_id: @params._id)

  @route "foodrun",
    path: "foodrun/:_id"
    template: "foodrun"
    data: ->
      foodrun: share.FoodRuns.findOne(_id: @params._id)
    onBeforeAction: (pause) ->
      # if a foodrun is shown that is to old or finished, show home view
      fr = share.FoodRuns.findOne(_id: @params._id)
      if !fr?
        console.log "no such foodrun, going home"
        Router.go "home"
      else
        d = new Date()
        yesterday = d.setDate(d.getDate() - 1);
        if fr.state == "finished" || fr.date < yesterday
          Router.go "home"



# global onBeforeActions. use an object to store them.
globalOnBeforeActions = {
  # redirect to the homepage if the current user is not logged in.
  loginRequired: (pause) =>
    if !Meteor.user()?
      # render the home page template, but keep the url
      this.render "home"
      # pause rendering
      pause()
}

Router.onBeforeAction globalOnBeforeActions.loginRequired,
  except: ["home"]
