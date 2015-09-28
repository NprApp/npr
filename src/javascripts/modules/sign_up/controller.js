export default class {
  constructor($http) {
    this.user = {};
    this.$http = $http;
  }
  signUp() {
    this.$http.post('/sign_up', {user: this.user}).then((result) => {
      console.log(result);
      this.message = result.data.success;
    }).catch((reason) => {
      console.log(reason);
    });
  }
}
