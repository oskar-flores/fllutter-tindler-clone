part of 'login_bloc.dart';

@Immutable()
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubbmiting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState(
      {required this.isEmailValid,
      required this.isPasswordValid,
      required this.isSubbmiting,
      required this.isSuccess,
      required this.isFailure});

  factory LoginState.empty() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: false,
        isSuccess: false,
        isFailure: false);
  }

  factory LoginState.loading() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory LoginState.failure() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: false,
        isSuccess: false,
        isFailure: true);
  }

  factory LoginState.success() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: false,
        isSuccess: true,
        isFailure: false);
  }

  LoginState update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubbmiting: false,
        isSuccess: true,
        isFailure: false);
  }

  LoginState copyWith(
      {required bool isEmailValid,
      required bool isPasswordValid,
      required bool isSubbmiting,
      required bool isSuccess,
      required bool isFailure,
      bool? isSubmitEnabled}) {
    return LoginState(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubbmiting: isSubbmiting,
        isSuccess: isSuccess,
        isFailure: isFailure);
  }
}
