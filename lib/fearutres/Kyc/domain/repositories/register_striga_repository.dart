import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/regsiter_striga_request.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';

import '../../../../core/errors/failure.dart';

abstract class RegisterStrigaRepository {
  Future<Either<Failure, RegisterStrigaResponse>> registerStriga(RegisterStrigaRequest request);
}
