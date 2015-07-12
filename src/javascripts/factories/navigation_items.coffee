angular.module "npr.app"
  .factory "NavigationItems", ->
    items: [
      url: "#/"
      label: "Dashboard"
    ,
      url: "#/cards"
      label: "Cards"
    ]
