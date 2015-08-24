angular.module("angular-data").factory "CacheService", ["CacheFactory", (CacheFactory) ->
  CacheFactory.get("$cacheService") || CacheFactory("$cacheService")
]
