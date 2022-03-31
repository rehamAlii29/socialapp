abstract class LoginSatets {}

class LoginIntialState extends LoginSatets {}

class LoginLoadingState extends LoginSatets {}

class LoginsucessState extends LoginSatets {
  final String? userid;
  LoginsucessState(this.userid);
}

class LoginErrorState extends LoginSatets {
  final String? error;
  LoginErrorState(this.error);
}
