Meteor.startup(function () {

  // if empty, populate the takeaway collection
  if(Takeaways.find().count() === 0) {

    // imports
    var fs = Npm.require('fs'),
      path = Npm.require('path');

    // load fixtures
    var basepath = path.resolve('.').split('.meteor')[0];
    var fixtures = basepath + "/private/fixtures/dishes.json";
    var json = fs.readFileSync(fixtures, 'utf8');
    var dishes = JSON.parse(json);

    // index that stores if a takeaway is allready in the collection
    // so the database doesn't get hit so hard
    var takeaway_index = [];

    // loop over the fixture and add dishes to the takeaways
    for (var i=0; i < dishes.length; i++) {

      // check if the takeaway is already on the index
      if (!_.contains(takeaway_index, dishes[i].takeaway.name)) {

        // if not, insert a new takeaway into the collection...
        Takeaways.insert({
          name:           dishes[i].takeaway.name,
          description:    dishes[i].takeaway.description,
          phone:          dishes[i].takeaway.phone,
          dishes:         []
        });

        // ...and put the name of the takeaway on the index
        takeaway_index.push(dishes[i].takeaway.name);
      };

      // store the dish's information in an object...
      var dish = {
        name:         dishes[i].name,
        description:  dishes[i].description,
        number:       dishes[i].order_number,
        price:        dishes[i].price
      };

      // ...and add the dish-object to the takeaway's dishes
      Takeaways.update({name: dishes[i].takeaway.name}, {$push: {dishes: dish}});

    };
  }

  //if empty, populate the user collection 
  if ( Meteor.users.find().count() === 0 ) {
      Accounts.createUser({
          username: 'benjamin',
          password: 'benjamin',
      });
      Accounts.createUser({
          username: 'sebastian',
          password: 'sebastian',
      });
      Accounts.createUser({
          username: 'niklas',
          password: 'niklas',
      });
  }
})
