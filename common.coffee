# on Client and Server
EasySearch.createSearchIndex('dishes',
  'collection'    : share.Dishes              # instanceof Meteor.Collection
  'field'         : ['name', 'description']   # can also be an array of fields
  'limit'         : 30                        # default: 10
  'takeaway'      : undefined
  'query' : (searchString) ->
    # Default query that will be used for searching
    query = EasySearch.getSearcher(@use).defaultQuery(@, searchString)
    console.log "ta: #{@takeaway}"
    if @takeaway
      query.takeaway = @takeaway
    query
)
