part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class SaveLoginSession extends LoginEvent {
  final LoginModel loginModel;

  const SaveLoginSession({required this.loginModel});
  @override
  List<Object> get props => [loginModel];
}
