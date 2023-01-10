import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/repositories/passengers_repository.dart';

class GetPassengers extends UseCase<PassengerResponse, int> {
  final PassengerRepository passengersRepository;

  GetPassengers({required this.passengersRepository});

  @override
  Future<Either<Failure, PassengerResponse>> call(int page) async {
    return await passengersRepository.getPassengers(page);
  }
}
