import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';
import 'package:posts_clean_arch/fearutres/passengers/presentation/bloc/passengers_bloc.dart';

import '../../../../injection_container.dart ';
import '../../domain/entities/passenger.dart';

class PassengersPage extends StatelessWidget {
  const PassengersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passengers"),
      ),
      body: BlocProvider<PassengersBloc>(
        create: (context) => sl<PassengersBloc>()
          ..add(GetPassengersEvent()),
        child: PassengersList(),
      ),
    );
  }
}

class PassengersList extends StatefulWidget {
  const PassengersList({Key? key}) : super(key: key);

  @override
  State<PassengersList> createState() => _PassengersListState();
}

class _PassengersListState extends State<PassengersList> {
  late ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_isBottom) {
      context.read<PassengersBloc>().add(GetPassengersEvent());
    }
  }

  bool get _isBottom {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= maxScroll * 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengersBloc, PassengersState>(
      builder: (context, state) {
        if (state.state == RequestState.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == RequestState.succeeded) {
          return ListView.builder(
              controller: controller,
              itemCount: state.hasReachedMax ? state.passengers.length : state.passengers.length + 1,
              itemBuilder: (context, index) {

                if (index >= state.passengers.length){
                  return Center(child: CircularProgressIndicator());
                }
                Passenger passenger =
                state.passengers[index];

                return ListTile(
                    title: Text(passenger.id.toString()),
                    subtitle: Text(passenger.name),
                trailing: Text(index.toString()),);
              });
        } else if (state.state == RequestState.failed) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
