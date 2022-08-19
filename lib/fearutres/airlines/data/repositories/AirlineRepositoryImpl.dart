import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/generic_api_calls.dart';
import 'package:posts_clean_arch/fearutres/airlines/data/datasources/airline_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/airlines/domain/entities/airline.dart';
import 'package:posts_clean_arch/fearutres/airlines/domain/repositories/airline_repository.dart';

class AirlineRepositoryImpl extends AirlineRepository {
  final AirlineRemoteDataSource dataSource;
  final GenericCall callApi;

  AirlineRepositoryImpl({required this.dataSource,required this.callApi});

  @override
  Future<Either<Failure, List<Airline>>> getAllAirlines() async {
    // TODO: implement getAllAirlines
    return await callApi(() => dataSource.getAllAirlines());
  }

}