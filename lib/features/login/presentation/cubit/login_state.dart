// login_state.dart
part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String? errorMessage;
  final Map<String, List<String>>? validationErrors;

  LoginErrorState({this.errorMessage, this.validationErrors});
}
