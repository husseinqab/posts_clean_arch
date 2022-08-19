import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/fearutres/auth/domain/entities/login.dart';

part 'login_validation_event.dart';

part 'login_validation_state.dart';

class LoginValidationBloc
    extends Bloc<LoginValidationEvent, LoginValidationState> {
  LoginValidationBloc()
      : super(LoginValidationInitial(
            email: ValidationItem(isValid: false),
            password: ValidationItem(isValid: false),
            formState: FormState.initial)) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
  }

  _emailChanged(EmailChanged event, Emitter<LoginValidationState> emit) {
    emit(state.copyWith(formState: FormState.editing));
    if (event.email.isEmpty) {
      emit(state.copyWith(
          validEmail: ValidationItem(
              isValid: false, message: 'Email Can not be empty')));
    } else if (event.email != 'email.com') {
      emit(state.copyWith(
          validEmail: ValidationItem(
              isValid: false, message: 'Please enter valid email')));
    } else {
      emit(state.copyWith(
          validEmail: ValidationItem(isValid: true, message: '')));
    }
  }

  _passwordChanged(PasswordChanged event, Emitter<LoginValidationState> emit) {
    emit(state.copyWith(formState: FormState.editing));
    if (event.password.isEmpty) {
      emit(state.copyWith(
          validPassword: ValidationItem(
              isValid: false, message: 'Password Can not be empty')));
    } else if (event.password != '123456') {
      emit(state.copyWith(
          validPassword: ValidationItem(
              isValid: false, message: 'Please Enter Valid Password')));
    } else {
      emit(state.copyWith(
          validPassword: ValidationItem(isValid: true, message: '')));
    }
  }
}
