part of 'login_bloc.dart';

@Immutable()
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return "email changed $email";
  }
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() {
    return "password  changed $password";
  }
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({required this.email, required this.password});

  @override
  List<Object> get props => [password, email];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.email, required this.password});

  @override
  List<Object> get props => [password, email];
}
