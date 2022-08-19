import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arch/fearutres/airlines/presentation/bloc/airline_bloc.dart';

import '../../../../injection_container.dart ';
import '../../domain/entities/airline.dart';

class AirlinesPage extends StatelessWidget {
  const AirlinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arlines"),
      ),
      body: BlocProvider<AirlineBloc>(
        create: (context) =>
        sl<AirlineBloc>()
          ..add(GetAllAirlinesEvent()),
        child: AirlinesList(),
      ),
    );
  }
}


class AirlinesList extends StatelessWidget {
  const AirlinesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AirlineBloc, AirlineState>(
        builder: (context, state)
    {
      if (state is AirlineInitial) {
        return const Center(child: Text('Posts page'));
      } else if (state is AirlineLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AirlineLoaded) {
        final List<Airline> airlines = state.airlinesList;
        return ListView.builder(
            itemCount: state.airlinesList.length,
            itemBuilder: (context, index) {
              Airline airline = airlines[index];
              return ListTile(
                title: Text(airline.name),
                subtitle: Text(airline.slogan),
                trailing: Container(
                    child: SizedBox(width: 150,height:100,child: Image.network(airline.logo))),
              );
            });
      } else if (state is AirlineFailed) {
        return Center(child: Text(state.message));
      }
      return const SizedBox();
    },
  );
}}

