
abstract class SignupState {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupState { }

class SignupLoadingState extends SignupState { }

class SignupSuccessState extends SignupState { }

class SignupError extends SignupState {
  SignupError(this.message);

  String? message;

  @override
  List<Object> get props => [];
}
