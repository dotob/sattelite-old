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

    #if empty, populate the user collection 
    if !_.any Meteor.users.find().fetch()
        Accounts.createUser
            username: 'benjamin'
            password: 'benjamin'
            email:    'mail@benjaminbuch.de'
        Accounts.createUser
            username: 'basti'
            password: 'basti'
            email:    'sk@dotob.de'
        Accounts.createUser
            username: 'niklas'
            password: 'niklas'
            email:    'niklas@niklas.de'

  # In your server code: define a method that the client can call
  Meteor.methods
    sendEmail: (to, subject, text) ->
      # Let other method calls from the same client start running,
      # without waiting for the email sending to complete.
      @unblock()

      # don’t allow sending email unless the user is logged in
      if !Meteor.userId()
        throw new Meteor.Error(403, "not logged in")

      # and here is where you can throttle the number of emails this user
      # is allowed to send per day
      Email.send
        to: to
        from: "mailer@sattelite.org"
        subject: subject
        text: text
