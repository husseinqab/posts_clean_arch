part of 'passengers_bloc.dart';

abstract class PassengersEvent extends Equatable {
  const PassengersEvent();
}

class GetPassengersEvent extends PassengersEvent {
  final GetPassengersParams params;

  const GetPassengersEvent({required this.params});

  @override
  // TODO: implement props
  List<Object?> get props => [params];
}
