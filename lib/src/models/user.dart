class User {
  String loginId;
  bool loggedIn;
  String accessToken;
  String companyName;
  String companyAddress;
  String welcomeMessage;
  String role;
  User(this.loginId, this.loggedIn, this.accessToken, this.companyAddress, this.companyName,this.welcomeMessage, this.role);
  User.loggedOut() {
    this.loginId = '';
    this.loggedIn = false;
    this.accessToken = '';
    this.companyName = '';
    this.companyAddress = '';
    this.welcomeMessage = '';
    this.role = '';
  }
}