part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UsersLoading extends UserState{
  @override
  List<Object?> get props => [];
}
class UsersSucceeded extends UserState{
  final List<User> users;
  const UsersSucceeded({required this.users});
  @override
  List<Object?> get props => [];
}

class UserFailed extends UserState{
  final String message;
  const UserFailed({required this.message});
  @override
  List<Object?> get props => [message];
}


