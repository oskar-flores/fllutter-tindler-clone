part of 'sign_up_bloc.dart';

@Immutable()
class SignUpState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubbmiting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SignUpState(
      {required this.isEmailValid,
        required this.isPasswordValid,
        required this.isSubbmiting,
        required this.isSuccess,
        required this.isFailure});

  //Initial State
  factory SignUpState.empty() {
    return SignUpState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: false,
        isSuccess: false,
        isFailure: false);
  }

  factory SignUpState.loading() {
    return SignUpState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory SignUpState.failure() {
    return SignUpState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: false,
        isSuccess: false,
        isFailure: true);
  }

  factory SignUpState.success() {
    return SignUpState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubbmiting: false,
        isSuccess: true,
        isFailure: false);
  }

  SignUpState update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubbmiting: false,
        isSuccess: true,
        isFailure: false);
  }

  SignUpState copyWith(
      {required bool isEmailValid,
        required bool isPasswordValid,
        required bool isSubbmiting,
        required bool isSuccess,
        required bool isFailure,
        bool? isSubmitEnabled}) {
    return SignUpState(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubbmiting: isSubbmiting,
        isSuccess: isSuccess,
        isFailure: isFailure);
  }
}
