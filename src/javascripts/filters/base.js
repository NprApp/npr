function accessFilter(store) {
  return function(items) {
    let result = [];
    let currentUser = store('user').get('current');
    items.forEach((item) => {
      if(item.access === 'all' || (item.access === 'admin' && currentUser.is_admin)) {
        result.push(item);
      }
    });
    return result;
  };
}


angular.module('app-filters', []);

angular.module('app-filters').filter('access', accessFilter);
