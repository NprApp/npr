export default function(store) {
  this.title = 'NFP - Natural Family Planning';
  store('user').get('current');
}
