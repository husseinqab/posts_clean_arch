import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/repositories/passengers_repository.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';

import '../../../../core/generic_api_calls.dart';
import '../datasources/passenger_remote_datasource.dart';

class PassengerRepositoryImpl extends PassengerRepository {
  final PassengersRemoteDataSource remoteDataSource;
  final GenericCall callApi;

  PassengerRepositoryImpl({required this.remoteDataSource,required this.callApi});

  @override
  Future<Either<Failure, PassengerResponse>> getPassengers(int page) async {
    return await callApi(() => remoteDataSource.getPassengers(page));
  }
}
