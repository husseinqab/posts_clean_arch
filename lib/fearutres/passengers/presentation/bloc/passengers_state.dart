part of 'passengers_bloc.dart';

abstract class PassengersState extends Equatable {
  const PassengersState();
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

  PassengersLoaded copyWith({
     List<Passenger>? passengers,
  }) {
    return PassengersLoaded(
      passengers: passengers ?? this.passengers,
    );
  }

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
