class UserStore {
  bool loggedIn = false;
  bool isRegister = false;
  bool forgotPassword = false;

  void setLogStatus(bool status) {
    loggedIn = status;
  }

  void setRegisterStatus(bool status) {
    isRegister = status;
  }

  void setForgotPassword(bool status) {
    forgotPassword = status;
  }
}
