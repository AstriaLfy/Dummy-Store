part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginSubmitted extends LoginEvent{
  final String gmail;
  final String password;

  LoginSubmitted(this.gmail, this.password);
}

class LoadProfile extends LoginEvent{}