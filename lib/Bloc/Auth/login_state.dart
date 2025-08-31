part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState{}
final class UnAuth extends LoginState{}


final class LoginSuccess extends LoginState{
  final Product profileData;
  LoginSuccess(this.profileData);
}

final class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
