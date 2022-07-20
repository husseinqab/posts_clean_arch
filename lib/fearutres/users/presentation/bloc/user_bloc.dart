import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/core/helper.dart';
import 'package:posts_clean_arch/core/usecase.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/user_usecase.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsers getAllUsers;

  UserBloc({required this.getAllUsers}) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetAllUsersEvent) {
        emit(UsersLoading());
        final eitherFailureOrUsers = await getAllUsers(NoParams());

        eitherFailureOrUsers.fold(
            (l) => emit(UserFailed(message: Helpers.mapFailureToMessage(l))),
            (r) => emit(UsersSucceeded(users: r)));
      }
    });
  }
}
