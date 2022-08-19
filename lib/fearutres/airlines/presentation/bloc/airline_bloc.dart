import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/core/usecase.dart';

import '../../../../core/helper.dart';
import '../../domain/entities/airline.dart';
import '../../domain/usecases/get_all_airlines.dart';

part 'airline_event.dart';

part 'airline_state.dart';

class AirlineBloc extends Bloc<AirlineEvent, AirlineState> {
  final GetAllAirlines getAllAirlines;

  AirlineBloc(this.getAllAirlines) : super(AirlineInitial()) {
    on<AirlineEvent>((event, emit) async {
      if (event is GetAllAirlinesEvent) {
        emit(AirlineLoading());
        final eitherFailureOrAirlinesList = await getAllAirlines(NoParams());

        eitherFailureOrAirlinesList.fold(
            (failure) => emit(
                AirlineFailed(message: Helpers.mapFailureToMessage(failure))),
            (airlines) => emit(AirlineLoaded(airlinesList: airlines)));
      }
    });
  }
}
