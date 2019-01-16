class User {
  String loginId;
  bool loggedIn;
  String accessToken;
  String companyName;
  String companyAddress;
  String welcomeMessage;
  String role;
  int timer;
  User(this.loginId, this.loggedIn, this.accessToken, this.companyAddress, this.companyName,this.welcomeMessage, this.role, this.timer);
  User.loggedOut() {
    this.loginId = '';
    this.loggedIn = false;
    this.accessToken = '';
    this.companyName = '';
    this.companyAddress = '';
    this.welcomeMessage = '';
    this.timer = 0;
    this.role = '';
  }
}