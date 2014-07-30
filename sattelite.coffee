# collections
Dishes = new Meteor.Collection "dishes"


if Meteor.isClient
  # config
  Accounts.ui.config { passwordSignupFields: 'USERNAME_ONLY' }
  
  Template.dishes.dishes = ->
    Dishes.find {}

  Template.deliveries.deliveries = ->
    dishes = Dishes.find({}).fetch()
    deliveries_grouped = _.groupBy dishes, (d) ->
      d.menu.id
    _.map _.values(deliveries_grouped), (g) ->
      _.first(g).menu


if Meteor.isServer
  Meteor.startup ->
    # if no dishes add some...
    if !_.any Dishes.find({}).fetch()
      fs = Npm.require 'fs'
      path = Npm.require 'path'
      basepath = path.resolve '.'
      file = "/Users/basti/Development/meteor/sattelite/dishes.json"
      dishes_json = fs.readFileSync file, 'utf8'
      dishes_init = JSON.parse dishes_json
      for dish in dishes_init
        Dishes.insert dish
