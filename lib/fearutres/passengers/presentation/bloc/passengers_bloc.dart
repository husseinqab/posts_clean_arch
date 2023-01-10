import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/core/helper.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';

part 'passengers_event.dart';

part 'passengers_state.dart';

const throttleDuration = Duration(milliseconds: 10000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.timeout(duration), mapper);
  };
}

class PassengersBloc extends Bloc<PassengersEvent, PassengersState> {
  final GetPassengers getPassengers;

  PassengersBloc(this.getPassengers) : super(const PassengersState()) {
    on<PassengersEvent>(transformer: throttleDroppable(throttleDuration),
        (event, emit) async {
      if (event is GetPassengersEvent) {
        // emit(state.copyWith(state: RequestState.loading));
        final eitherFailureOrPassengers = await getPassengers(state.page);

        eitherFailureOrPassengers.fold(
            (l) => emit(state.copyWith(
                message: Helpers.mapFailureToMessage(l),
                state: RequestState.failed)), (r) {
          if (state.page == 10) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            emit(state.copyWith(
                passengers: List.of(state.passengers)..addAll(r.passengersList),
                state: RequestState.succeeded,
                page: state.page + 1,
                hasReachedMax: false));
          }
        });
      }
    });
  }
}
