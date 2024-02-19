
abstract class LoginEvent {
  const LoginEvent();

  List<Object> get props => [];
}

class ValidationLoginEvent extends LoginEvent {
  const ValidationLoginEvent(this.request);

  final Map request;

  @override
  List<Object> get props => [request];
}
