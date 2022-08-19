import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String email;
  final String password;

  const LoginEntity({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}


class LoginValidationStatus extends Equatable {
  final bool isValidPassword;

  final bool isValidEmail;
  final bool isValidForm;

  const LoginValidationStatus(
      {this.isValidPassword = false, this.isValidEmail = false, this.isValidForm = false});

  LoginValidationStatus copyWith({bool? validPassword, bool? validEmail, bool? validForm}) {
    return LoginValidationStatus(isValidPassword: validPassword ?? isValidPassword,
        isValidEmail: validEmail ?? isValidEmail,
        isValidForm: validForm ?? isValidForm);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isValidPassword,isValidEmail,isValidForm];
}

class ValidationItem {
  final String message;
  final bool isValid;

   ValidationItem({this.message = "",this.isValid = false});
}