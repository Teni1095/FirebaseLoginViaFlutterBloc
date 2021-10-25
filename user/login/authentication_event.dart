part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticateUsingGmail extends AuthenticationEvent {
} //Create account or sign in using GoogleAccount

class AuthenticateSignUpUsingEmailAndPassword extends AuthenticationEvent {
  final String email, password;

  const AuthenticateSignUpUsingEmailAndPassword(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
} //Create account Email and Password

class AuthenticateSignInUsingEmailAndPassword extends AuthenticationEvent {
  final String email, password;

  const AuthenticateSignInUsingEmailAndPassword(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
} //Sign in Email and Password
