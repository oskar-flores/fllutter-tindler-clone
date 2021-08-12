import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chili/repositories/userRepository.dart';
import 'package:chili/ui/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required userRepository}) : this._userRepository = userRepository;

  @override
  SignUpState get initialState => SignUpState.empty();

  @override
  Stream<SignUpState> transformEvents(Stream<SignUpEvent> events,
      Stream<SignUpState> Function(SignUpEvent event) next) {
    final nonDebouncingStream = events.where((event) {
      return (event is! EmailChanged || event is! PasswordChanged);
    });

    final debounceStreams = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
        nonDebouncingStream.mergeWith([debounceStreams]), next);
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapSignUpWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<SignUpState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SignUpState> _mapSignUpWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield SignUpState.loading();
    try {
      await _userRepository.signUpWithEmail(email, password);
      yield SignUpState.success();
    } catch (_) {
      yield SignUpState.failure();
    }
  }
}
