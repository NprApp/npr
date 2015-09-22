export default function($cookies) {
  'ngInject';
  return {
    onStateChange: function(event, toState) {
      if ((!$cookies.get('xUserToken') || !$cookies.get('xUserEmail')) && toState.name !== 'login') {
        console.log(toState.name);
        event.preventDefault();
        window.location.hash = '#/login';
      }
      return true;
    }
  };
}
