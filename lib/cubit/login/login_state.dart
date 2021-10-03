part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState(this.message);
}

class LoginSuccessState extends LoginState {}
