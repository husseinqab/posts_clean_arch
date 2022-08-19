import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/repositories/passengers_repository.dart';

class GetPassengersParams {
  final int page;
  GetPassengersParams({this.page = 0});
}

class GetPassengers extends UseCase<PassengerResponse, GetPassengersParams> {
  final PassengerRepository passengersRepository;

  GetPassengers({required this.passengersRepository});

  @override
  Future<Either<Failure, PassengerResponse>> call(
      GetPassengersParams params) async {
    return await passengersRepository.getPassengers(params);
  }
}
