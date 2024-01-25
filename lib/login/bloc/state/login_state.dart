
abstract class LoginState {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState { }

class LoginLoadingState extends LoginState { }

class LoginSuccessState extends LoginState { }

class LoginError extends LoginState {
  LoginError(this.message);

  String? message;

  @override
  List<Object> get props => [];
}
