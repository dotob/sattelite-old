if Meteor.isServer
  Meteor.startup ->
    # if no dishes add some...
    if !_.any share.Dishes.find({}).fetch()
      fs = Npm.require 'fs'
      path = Npm.require 'path'
      basepath = path.resolve '.'
      file = basepath + "/dishes.json"
      dishes_json = fs.readFileSync file, 'utf8'
      dishes_init = JSON.parse dishes_json
      for dish in dishes_init
        share.Dishes.insert dish
