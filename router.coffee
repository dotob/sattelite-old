Router.map ->
  @route "takeaways",
    path: "/"
    template: "takeaways"
    data: ->
      takeaways: share.Takeaways.find({})
      foodruns: share.FoodRuns.find({})

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


