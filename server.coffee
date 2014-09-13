if Meteor.isServer
  Meteor.startup ->
    # if no dishes add some...
    if !_.any share.Dishes.find({}).fetch()
      fs = Npm.require 'fs'
      path = Npm.require 'path'
      basepath = path.resolve('.').split('.meteor')[0]
      file = basepath + "/dishes.json"
      dishes_json = fs.readFileSync file, 'utf8'
      dishes_init = JSON.parse dishes_json
      for dish in dishes_init
        t =
          name:        dish.takeaway.name
          description: dish.takeaway.description
          phone:       dish.takeaway.phone
        dish.takeaway = ""
        dish_id = share.Dishes.insert dish
        new_dish = share.Dishes.findOne(dish_id)
        
        ta = share.Takeaways.findOne({name: t.name})
        # if takeaway does not exists add it
        if !ta
          ta_id = share.Takeaways.insert t
        else
          ta_id = ta._id

        # ...and add the dish-object to the takeaway's dishes
        share.Takeaways.update({_id: ta_id}, {$push: {dishes: new_dish}});
        share.Dishes.update({_id: dish_id}, {$set: {takeaway: ta_id}});
