class User {
  String loginId;
  bool loggedIn;
  String accessToken;
  String companyName;
  String companyAddress;
  User(this.loginId, this.loggedIn, this.accessToken, this.companyAddress, this.companyName);
  User.loggedOut() {
    this.loginId = '';
    this.loggedIn = false;
    this.accessToken = '';
    this.companyName = '';
    this.companyAddress = '';
  }
}