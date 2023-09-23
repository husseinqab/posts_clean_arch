import 'package:equatable/equatable.dart';

import '../../domain/entities/user_info_response.dart';
import '../../domain/entities/user_info_response.dart';

enum RequestState { initial, loading, succeeded, failed }

class UserInfoState extends Equatable {
  final RequestState state;
  final String message;
  final UserInfoResponse? userInfoResponse;

  const UserInfoState({this.state = RequestState.initial,
    this.message = "",
    this.userInfoResponse});

  UserInfoState copyWith({RequestState? state,
    String? message,
    UserInfoResponse? userInfoResponse}) {
    return UserInfoState(
        state: state ?? this.state,
        message: message ?? this.message,
        userInfoResponse: userInfoResponse ??
            this.userInfoResponse);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [state, message, userInfoResponse];

}
class UserInfoInitial extends UserInfoState {
  @override
  List<Object> get props => [];
}

class UserInfoLoading extends UserInfoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserInfoLoaded extends UserInfoState {
  final UserInfoResponse userInfoResponse;

  const UserInfoLoaded({required this.userInfoResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [userInfoResponse];
}

class UserInfoFailed extends UserInfoState {
  final String message;

  const UserInfoFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
