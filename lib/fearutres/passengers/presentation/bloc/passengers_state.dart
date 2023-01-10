part of 'passengers_bloc.dart';

enum RequestState { initial, loading, succeeded, failed }

class PassengersState extends Equatable {
  final int page;
  final RequestState state;
  final String message;
  final bool hasReachedMax;
  final List<Passenger> passengers;

  const PassengersState(
      {this.state = RequestState.initial,
      this.message = "",
      this.passengers = const <Passenger>[],
      this.page = 1,
      this.hasReachedMax = false});

  PassengersState copyWith(
      {RequestState? state,
      String? message,
      List<Passenger>? passengers,
      int? page,
      bool? hasReachedMax}) {
    return PassengersState(
        state: state ?? this.state,
        message: message ?? this.message,
        passengers: passengers ?? this.passengers,
        page: page ?? this.page,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [state, message, passengers,page,hasReachedMax];
}

class PassengersInitial extends PassengersState {
  @override
  List<Object> get props => [];
}

class PassengersLoading extends PassengersState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PassengersLoaded extends PassengersState {
  final List<Passenger> passengers;

  const PassengersLoaded({required this.passengers});

  @override
  // TODO: implement props
  List<Object?> get props => [passengers];
}

class PassengerFailed extends PassengersState {
  final String message;

  const PassengerFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
