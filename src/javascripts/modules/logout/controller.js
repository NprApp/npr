export default function($cookies, $state) {
  'ngInject';
  $cookies.remove('xUserToken');
  $cookies.remove('xUserEmail');
  $state.reload();
}
