# on Client and Server
EasySearch.createSearchIndex('dishes', 
  'collection'    : share.Dishes                    # instanceof Meteor.Collection
  'field'         : ['name', 'description']   # can also be an array of fields
  'limit'         : 20                        # default: 10
  'sort' : ->
    {score: -1}
)
