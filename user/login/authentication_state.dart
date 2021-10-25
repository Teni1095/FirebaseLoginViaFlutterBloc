part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {
  final Object errorMessage;

  const Unauthenticated(this.errorMessage);
} //Authentication Failed

class Authenticating extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final EBUser user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [];
} //Successfully Authenticated
