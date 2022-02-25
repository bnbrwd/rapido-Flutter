part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoaded extends LoginState {
  LoginResponse loginResponse;
  LoginLoaded(this.loginResponse);
}

