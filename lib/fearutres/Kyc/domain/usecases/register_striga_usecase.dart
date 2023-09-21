import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/regsiter_striga_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/verify_email_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/repositories/register_striga_repository.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/repositories/passengers_repository.dart';

class RegisterInStriga extends UseCase<RegisterStrigaResponse, RegisterStrigaRequest> {
  final RegisterStrigaRepository registerStrigaRepository;

  RegisterInStriga({required this.registerStrigaRepository});

  @override
  Future<Either<Failure, RegisterStrigaResponse>> call(RegisterStrigaRequest request) async {
    return await registerStrigaRepository.registerStriga(request);
  }
}

class VerifyEmailStriga extends UseCase<String, VerifyEmailRequest> {
  final RegisterStrigaRepository registerStrigaRepository;

  VerifyEmailStriga({required this.registerStrigaRepository});

  @override
  Future<Either<Failure, String>> call(VerifyEmailRequest request) async {
    return await registerStrigaRepository.verifyEmailStriga(request);
  }
}
