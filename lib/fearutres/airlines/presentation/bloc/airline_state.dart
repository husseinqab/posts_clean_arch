part of 'airline_bloc.dart';

abstract class AirlineState extends Equatable {
  const AirlineState();
}

class AirlineInitial extends AirlineState {
  @override
  List<Object> get props => [];
}

class AirlineLoading extends AirlineState {
  @override
  List<Object> get props => [];
}

class AirlineLoaded extends AirlineState {
  final List<Airline> airlinesList;

  const AirlineLoaded({required this.airlinesList});

  @override
  List<Object> get props => [airlinesList];
}

class AirlineFailed extends AirlineState {
  final String message;

  const AirlineFailed({required this.message});

  @override
  List<Object> get props => [message];
}
