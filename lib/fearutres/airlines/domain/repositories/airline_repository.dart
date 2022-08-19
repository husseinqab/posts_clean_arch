import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/fearutres/airlines/domain/entities/airline.dart';

abstract class AirlineRepository {
  Future<Either<Failure,List<Airline>>> getAllAirlines();
}