#first stubs for the routes
Router.map ->
  
  # home screen shows a login form if the user's not logged in.
  # if the user is logged in, if there's no foodrun 
  # it shows a list of takeaways plus a button "start a food run".
  @route "home",
    path: "/"

  # if a foodrun is started, the menu of the chosen takeaway is shown.
  @route "foodrun",
    path: "/foodrun/:id"

  # there's a summary of the bespoken dishes for the organizer 
  @route "foodrun_summary",
    path: "/foodrun/:id/summary"
