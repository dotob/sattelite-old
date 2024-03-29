Router.map ->
  @route "home",
    path: "/"
    template: "home"
    data: ->
      takeaways: ->
        console.log "hello"
        share.Takeaways.find()
      foodruns: ->
        d = new Date()
        m = d.getMonth()+1
        month = if m < 10 then "0#{m}" else m
        day = if d.getDate() < 10 then "0#{d.getDate()}" else d.getDate()
        dstr = "#{d.getFullYear()}-#{month}-#{day}T00:00:00Z"
        share.FoodRuns.find({date: { $gte: new Date(dstr)}, state: "ongoing"})

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
      favorites: ->
        consolelog "hi there"
        fr = @data().foodrun
        fr_by_ta = share.FoodRuns.find(takeaway: fr.takeaway).fetch()
        console.dir fr_by_ta
        favorite_dishes = _(fr_by_ta)
          .flatten("f.bespokenDishes").values()
        console.dir favorite_dishes 
        #  .groupBy((d) -> d._id)
        # .values()
        # .sortBy(array -> array.length)
        # .map(array -> array[0])
        # .first(5)
        # .value()
        favorite_dishes

    onBeforeAction: ->
      console.log "bla"
      # if a foodrun is shown that is to old or finished, show home view
      fr = @data().foodrun
      if !fr?
        console.log "no such foodrun(#{@params._id}), going home"
        Router.go "home"
      else
        yesterday = moment().day(-1).toDate()
        console.log yesterday.toString()
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

#Router.onBeforeAction globalOnBeforeActions.loginRequired,
#  except: ["home"]
