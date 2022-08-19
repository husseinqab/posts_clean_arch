import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';

import '../../../../core/errors/failure.dart';

abstract class PassengerRepository {
  Future<Either<Failure, PassengerResponse>> getPassengers(
      GetPassengersParams params);
}
