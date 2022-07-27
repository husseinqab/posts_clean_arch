import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
@override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}
class NoInternetFailure extends Failure {}
class UnAurhtorizedFailure extends Failure {}
class NotFoundFailure extends Failure {}
class UnExpectedFailure extends Failure {}