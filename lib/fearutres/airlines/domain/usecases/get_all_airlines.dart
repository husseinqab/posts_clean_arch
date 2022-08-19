import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/airlines/domain/entities/airline.dart';
import 'package:posts_clean_arch/fearutres/airlines/domain/repositories/airline_repository.dart';

class GetAllAirlines extends UseCaseListing<Airline,NoParams> {
  final AirlineRepository airlineRepository;

  GetAllAirlines({required this.airlineRepository});
  @override
  Future<Either<Failure, List<Airline>>> call(NoParams params) async {
    return await airlineRepository.getAllAirlines();
  }

}