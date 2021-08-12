import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chili/repositories/userRepository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository);

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final uuid = await _userRepository.getUser();
        if (uuid != null) {
          final isFirstTime = await _userRepository.isFirstTime(uuid);
          if (!isFirstTime) {
            yield AuthenticatedButNotSet(uuid);
          } else {
            yield Authenticated(uuid);
          }
        } else {
          yield Unauthenticated();
        }
      }
    } catch (_) {}
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      final userId = await _userRepository.getUser();
      if (userId != null) {
        var isFirstTime = await _userRepository.isFirstTime(userId);

        if (!isFirstTime) {
          yield AuthenticatedButNotSet(userId);
        } else {
          yield Authenticated(userId);
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {}
  }

  Stream<AuthenticationState> _mapLoggedOutState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
