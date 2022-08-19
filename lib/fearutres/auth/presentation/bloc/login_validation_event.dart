part of 'login_validation_bloc.dart';

abstract class LoginValidationEvent extends Equatable {
  const LoginValidationEvent();
}

class EmailChanged extends LoginValidationEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginValidationEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [password];
}
