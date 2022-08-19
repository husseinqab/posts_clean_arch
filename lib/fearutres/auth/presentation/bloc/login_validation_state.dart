part of 'login_validation_bloc.dart';

enum FormState { initial, editing, submitted }

class LoginValidationState extends Equatable {
  final ValidationItem email;
  final ValidationItem password;
  final FormState formState;

  const LoginValidationState(
      {required this.email, required this.password, required this.formState});

  LoginValidationState copyWith(
      {ValidationItem? validPassword, ValidationItem? validEmail, FormState? formState}) {
    return LoginValidationState(
        email: validEmail ?? email,
        password: validPassword ?? password,
        formState: formState ?? this.formState
    );
  }

  bool get isValidForm => email.isValid && password.isValid;

  dynamic get emailErrorText {
    if (formState == FormState.initial) {
      return null;
    }

    if (formState == FormState.editing) {
      if (email.isValid) {
        return null;
      } else {
        return email.message;
      }
    }

    return null;
  }


  dynamic get passwordErrorText {
    if (formState == FormState.initial) {
      return null;
    }

    if (formState == FormState.editing) {
      if (password.isValid) {
        return null;
      } else {
        return password.message;
      }
    }

    return null;
  }

  bool get isEditing => formState == FormState.editing;

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class LoginValidationInitial extends LoginValidationState {
  const LoginValidationInitial(
      {required super.email, required super.password, required super.formState});


  @override
  List<Object> get props => [];
}

class LoginIsInvalid extends LoginValidationStatus {
  final LoginValidationStatus status;

  const LoginIsInvalid({required this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [status];
}

class LoginValid extends LoginValidationStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
