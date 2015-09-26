angular.module('app-filters').filter('moment', function() {
  return function(date, format) {
    return moment(date).format(format);
  };
}).filter('recordDayOfMonth', function() {
  return function(date) {
    return moment(date).format('DD');
  };
}).filter('recordDayOfWeek', function() {
  return function(date) {
    return moment(date).format('dd');
  };
}).filter('recordStartOfMonth', function() {
  return function(date) {
    var dateOfMonth;
    dateOfMonth = moment(date).format('DD');
    if (dateOfMonth === '01') {
      return moment(date).format('MMM');
    }
  };
});
