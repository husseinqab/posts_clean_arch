import 'package:equatable/equatable.dart';

enum RequestState { initial, loading, succeeded, failed }

class VerifyIdentityState extends Equatable {
  final RequestState state;
  final String message;
  final String? verifyResponse;

  const VerifyIdentityState({this.state = RequestState.initial,
    this.message = "",
    this.verifyResponse});

  VerifyIdentityState copyWith({RequestState? state,
    String? message,
    String? verifyResponse}) {
    return VerifyIdentityState(
        state: state ?? this.state,
        message: message ?? this.message,
        verifyResponse: verifyResponse ??
            this.verifyResponse);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [state, message, verifyResponse];

}
class VerifyIdentityInitial extends VerifyIdentityState {
  @override
  List<Object> get props => [];
}

class VerifyIdentityLoading extends VerifyIdentityState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VerifyIdentityLoaded extends VerifyIdentityState {
  final String verifyResponse;

  const VerifyIdentityLoaded({required this.verifyResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [verifyResponse];
}

class VerifyIdentityFailed extends VerifyIdentityState {
  final String message;

  const VerifyIdentityFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
