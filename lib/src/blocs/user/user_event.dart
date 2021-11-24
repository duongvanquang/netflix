import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserSignupButtonSubmitted extends UserEvent {
  final String email;
  final String password;
  const UserSignupButtonSubmitted(
      {required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class UserLoginButtonSubmitted extends UserEvent {
  final String email;
  final String password;
  const UserLoginButtonSubmitted({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class UserForgotPasswordSubmitted extends UserEvent {
  final String email;
  const UserForgotPasswordSubmitted({required this.email});
  @override
  List<Object> get props => [email];
}
