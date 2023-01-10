part of 'passengers_bloc.dart';

abstract class PassengersEvent extends Equatable {
  const PassengersEvent();
}

class GetPassengersEvent extends PassengersEvent {
  const GetPassengersEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
