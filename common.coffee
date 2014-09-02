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


Schemas.Menu = new SimpleSchema({
  name: {
    type: String,
    label: "Title",
    max: 200
  },
  description: {
    type: String,
    label: "Beschreibung",
    optional: true,
    max: 200
  },
  phone: {
    type: String,
    label: "Telefon",
    max: 200
  },
  id: {
    type: String,
    label: "Title",
    max: 200
  }
})


share.Dishes = new Meteor.Collection "dishes"
Schemas.Dish = new SimpleSchema({
  name: {
    type: String,
    label: "Title",
    max: 200
  },
  menu: {
    type: Schemas.Menu,
    label: "Lieferant",
    max: 200
  },
  order_count: {
    type: Number,
    label: "Bestellanzahl",
    max: 200
  },
  order_number: {
    type: String,
    label: "Bestellnummer",
    optional: true,
    max: 200
  },
  price: {
    type: String,
    label: "Preis",
    max: 200
  },
  description: {
    type: String,
    label: "Beschreibung",
    optional: true,
    max: 200
  }
})

share.Dishes.attachSchema(Schemas.Dish);


share.Orders = new Meteor.Collection "orders"
Schemas.Order = new SimpleSchema({
  order_master: {
    type: Schemas.User,
    label: "Haupt-Besteller",
    max: 200
  },
  delivery: {
    type: String,
    label: "Lieferant",
    max: 200
  },
  date: {
    type: Date,
    label: "Bestelldatum",
  }
})
share.Orders.attachSchema(Schemas.Order);


share.OrderItems = new Meteor.Collection "order_items"
Schemas.OrderItem = new SimpleSchema({
  user: {
    type: Schemas.User,
    label: "Besteller",
    max: 200
  },
  dish: {
    type: Schemas.Dish,
    label: "Gericht",
    max: 200
  },
  order: {
    type: Schemas.Order,
    label: "Bestellung",
  }
})
share.OrderItems.attachSchema(Schemas.OrderItem);
