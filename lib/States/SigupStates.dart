abstract class SignUpSatets {}

class SignUpIntialState extends SignUpSatets {}

class SignUpLoadingState extends SignUpSatets {}

class SignUpsucessState extends SignUpSatets {}

class SignUpErrorState extends SignUpSatets {
  final String? error;
  SignUpErrorState(this.error);
}

class CreteUserLoadingState extends SignUpSatets {}

class CreateUsersucessState extends SignUpSatets {}

class CreateUserErrorState extends SignUpSatets {
  final String? error;
  CreateUserErrorState(this.error);
}
