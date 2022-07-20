import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart ';
import '../bloc/user_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: BlocProvider<UserBloc>(
        create: (context) => sl<UserBloc>()..add(GetAllUsersEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return CircularProgressIndicator();
            } else if (state is UserFailed) {
              return Center(child: Text(state.message));
            } else if (state is UsersSucceeded) {
              return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(state.users[index].phone));
                  });
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
