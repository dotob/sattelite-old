# collections
Schemas = {}

Schemas.User = new SimpleSchema({
    _id: {
        type: String,
        regEx: SimpleSchema.RegEx.Id
    },
    username: {
        type: String,
        regEx: /^[a-z0-9A-Z_]{3,15}$/
    },
    emails: {
        type: [Object]
    },
    "emails.$.address": {
        type: String,
        regEx: SimpleSchema.RegEx.Email
    },
    "emails.$.verified": {
        type: Boolean
    },
    createdAt: {
        type: Date
    }
})
Meteor.users.attachSchema(Schemas.User);

share.Takeaways = new Meteor.Collection "takeaways"
Schemas.Takeaway = new SimpleSchema({
  name: {
    type: String,
    label: "Name",
    max: 200
  },
  description: {
    type: String,
    label: "Description",
    optional: true,
    max: 200
  },
  phone: {
    type: String,
    label: "Phone Number",
    max: 200
  },
  dishes: {
    type: [Object],
    label: "Dishes",
    optional: true
  },
})
share.Takeaways.attachSchema(Schemas.Takeaway);

share.Dishes = new Meteor.Collection "dishes"
Schemas.Dish = new SimpleSchema({
  name: {
    type: String,
    label: "Title",
    max: 200
  },
  takeaway: {
    type: Schemas.Takeaway,
    label: "Takeaway",
    max: 200
  },
  order_count: {
    type: Number,
    label: "Order Count",
    max: 200
  },
  order_number: {
    type: String,
    label: "Order Number",
    optional: true,
    max: 200
  },
  price: {
    type: String,
    label: "Price",
    max: 200
  },
  description: {
    type: String,
    label: "Description",
    optional: true,
    max: 200
  }
})

share.Dishes.attachSchema(Schemas.Dish);

share.FoodRuns = new Meteor.Collection "food_runs"
Schemas.FoodRun = new SimpleSchema({
  organizer: {
    type: Schemas.User,
    label: "Organizer",
    max: 200
  },
  takeaway: {
    type: String,
    label: "Takeaway",
    max: 200
  },
  date: {
    type: Date,
    label: "FoodRun date",
  },
  order_item: {
    type: [Schemas.OrderItem]
  }
})
share.FoodRuns.attachSchema(Schemas.FoodRun);

share.OrderItems = new Meteor.Collection "order_items"
Schemas.OrderItem = new SimpleSchema({
  user: {
    type: Schemas.User,
    label: "Participant",
    max: 200
  },
  dish: {
    type: Schemas.Dish,
    label: "Dish",
    max: 200
  },
  order: {
    type: Schemas.Order,
    label: "Order",
  }
})
share.OrderItems.attachSchema(Schemas.OrderItem);