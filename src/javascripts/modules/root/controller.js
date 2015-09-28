import NavigationItems from '../../factories/navigation-items.js';

export default function(store) {
  'ngInject';
  this.currentUser = store('user').get('current');
  this.navigationItems = NavigationItems;
}
