angular.module "npr.app"
  .factory "NavigationItems", ->
    items: [
      state: "root.cards"
      label: "Cards"
    ,
      state: "root.mucus_types"
      label: "Mucus types"
    ,
      state: "root.record_types"
      label: "Record types"
    ]
