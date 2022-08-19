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
          ..add(GetPassengersEvent(
              params: GetPassengersParams())),
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

  List<Passenger> passengers = [];

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
    if (controller.position.extentAfter < 500) {
      context.read<PassengersBloc>().add(GetPassengersEvent(params: GetPassengersParams()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengersBloc, PassengersState>(
      builder: (context, state) {
        if (state is PassengersInitial) {
          return const Center(child: Text('Posts page'));
        } else if (state is PassengersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PassengersLoaded) {
          passengers = state.passengers;
          return ListView.builder(
              controller: controller,
              itemCount: passengers.length,
              itemBuilder: (context, index) {
                Passenger passenger =
                passengers[index];
                return ListTile(
                    title: Text(passenger.id.toString()),
                    subtitle: Text(passenger.name),
                trailing: Text(index.toString()),);
              });
        } else if (state is PassengerFailed) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
