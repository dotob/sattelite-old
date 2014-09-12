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
        share.Dishes.insert dish
        ta = share.Takeaways.findOne({name: dish.takeaway.name})
        # if takeaway no exists add it
        if !ta
          ta_id = share.Takeaways.insert
            name:           dish.takeaway.name
            description:    dish.takeaway.description
            phone:          dish.takeaway.phone
        else
          ta_id = ta._id

        new_dish =
          _id:          Meteor.ObjectId
          name:         dish.name
          description:  dish.description
          number:       dish.order_number
          price:        parseFloat dish.price

        # ...and add the dish-object to the takeaway's dishes
        console.log new_dish
        share.Takeaways.update({_id: ta_id}, {$push: {dishes: new_dish}});
