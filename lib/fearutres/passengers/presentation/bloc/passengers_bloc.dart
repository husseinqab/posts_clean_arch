import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/core/helper.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';

part 'passengers_event.dart';

part 'passengers_state.dart';

class PassengersBloc extends Bloc<PassengersEvent, PassengersState> {
  final GetPassengers getPassengers;

  PassengersBloc(this.getPassengers) : super(PassengersInitial()) {
    on<PassengersEvent>((event, emit) async {
      if (event is GetPassengersEvent) {
        emit(PassengersLoading());

        final eitherFailureOrPassengers = await getPassengers(event.params);
        

        eitherFailureOrPassengers.fold(
            (l) =>
                emit(PassengerFailed(message: Helpers.mapFailureToMessage(l))),
            (r) {
              emit(PassengersLoaded(passengers: r.passengersList));
            });
      }
    });
  }
}
