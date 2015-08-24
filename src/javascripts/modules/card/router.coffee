angular.module("npr.app").config ["$stateProvider", ($stateProvider) ->
  $stateProvider.state
    name: "root.cards.card"
    url: "/:id"
    controller: "CardController"
    controllerAs: "card"
    templateUrl: "modules/card/template.html"
    resolve:
      record_types: ["Store", (Store) ->
        Store("record_type").query()
      ]
      mucus_types: ["Store", (Store) ->
        Store("mucus_type").query()
      ]
      records: ["Store", "record_types", "mucus_types", "$stateParams", (Store, record_types, mucus_types, $stateParams) ->
        Store("record").query(card_id: $stateParams.id)
      ]
]
