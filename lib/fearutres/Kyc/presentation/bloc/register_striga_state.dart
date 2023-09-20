import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';

enum RequestState { initial, loading, succeeded, failed }

class RegisterStrigaState extends Equatable {
  final RequestState state;
  final String message;
  final RegisterStrigaResponse? registerStrigaResponse;

  const RegisterStrigaState({this.state = RequestState.initial,
    this.message = "",
    this.registerStrigaResponse});

  RegisterStrigaState copyWith({RequestState? state,
    String? message,
    RegisterStrigaResponse? registerStrigaResponse}) {
    return RegisterStrigaState(
        state: state ?? this.state,
        message: message ?? this.message,
        registerStrigaResponse: registerStrigaResponse ??
            this.registerStrigaResponse);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [state, message, registerStrigaResponse];

}
class RegisterStrigaInitial extends RegisterStrigaState {
  @override
  List<Object> get props => [];
}

class RegisterStrigaLoading extends RegisterStrigaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterStrigaLoaded extends RegisterStrigaState {
  final RegisterStrigaResponse registerStrigaResponse;

  const RegisterStrigaLoaded({required this.registerStrigaResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [registerStrigaResponse];
}

class RegisterStrigaFailed extends RegisterStrigaState {
  final String message;

  const RegisterStrigaFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
