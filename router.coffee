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
      takeaway: share.Takeaways.findOne(@params._id)

  @route "foodrun",
    path: "foodrun/:_id"
    template: "foodrun"
    data: ->
      foodrun: share.FoodRuns.findOne(@params._id)
    onBeforeAction: ->
      # if a foodrun is shown that is to old or finished, show home view
      fr = @data().foodrun
      if !fr?
        console.log "no such foodrun(#{@params._id}), going home"
        Router.go "home"
      else
        d = new Date()
        yesterday = d.setDate(d.getDate() - 1);
        if fr.state == "finished" || fr.date < yesterday
          console.log "foodrun(#{@params._id}) is finished or too old, going home"
          Router.go "home"
        else
          # is this right here??
          console.log "set searcher to takeaway: #{fr.takeaway} of #{fr}"
          EasySearch.changeProperty('dishes', 'takeaway', fr.takeaway)

# global onBeforeActions. use an object to store them.
globalOnBeforeActions =
  # redirect to the homepage if the current user is not logged in.
  loginRequired: (pause) =>
    if !Meteor.userId()?
      # render the home page template, but keep the url
      this.render "home"
      # pause rendering
      pause()

Router.onBeforeAction globalOnBeforeActions.loginRequired,
  except: ["home"]
