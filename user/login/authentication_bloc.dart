import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:entre_to_buss/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticateUsingGmail) {
      yield Authenticating();
      try {
        var user = await userRepository.signInWithGoogle();
        yield Authenticated(user);
      } catch (e) {
        yield Unauthenticated(e);
      }
    } else if (event is AuthenticateSignUpUsingEmailAndPassword) {
      yield Authenticating();
      try {
        var user = await userRepository.signUpWithEmailAndPassword(
            event.email, event.password);
        yield Authenticated(user);
      } catch (e) {
        yield Unauthenticated(e);
      }
    } else if (event is AuthenticateSignInUsingEmailAndPassword) {
      yield Authenticating();
      try {
        var user = await userRepository.signInWithEmailAndPassword(
            event.email, event.password);
        yield Authenticated(user);
      } catch (e) {
        yield Unauthenticated(e);
      }
    }
  }
}
