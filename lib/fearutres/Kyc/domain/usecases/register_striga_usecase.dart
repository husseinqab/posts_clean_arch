import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/regsiter_striga_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/update_data_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/user_info_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/verify_identity_request.dart';
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

class VerifyEmailStriga extends UseCase<String, VerifyIdentityRequest> {
  final RegisterStrigaRepository registerStrigaRepository;

  VerifyEmailStriga({required this.registerStrigaRepository});

  @override
  Future<Either<Failure, String>> call(VerifyIdentityRequest request) async {
    return await registerStrigaRepository.verifyEmailStriga(request);
  }
}

class VerifyPhoneStriga extends UseCase<String, VerifyIdentityRequest> {
  final RegisterStrigaRepository registerStrigaRepository;

  VerifyPhoneStriga({required this.registerStrigaRepository});

  @override
  Future<Either<Failure, String>> call(VerifyIdentityRequest request) async {
    return await registerStrigaRepository.verifyPhoneStriga(request);
  }
}

class UpdateDataStriga extends UseCase<String, UpdateDataRequest> {
  final RegisterStrigaRepository registerStrigaRepository;

  UpdateDataStriga({required this.registerStrigaRepository});

  @override
  Future<Either<Failure, String>> call(UpdateDataRequest request) async {
    return await registerStrigaRepository.updateData(request);
  }
}

class GetUserInfo extends UseCase<UserInfoResponse, NoParams> {
  final RegisterStrigaRepository registerStrigaRepository;

  GetUserInfo({required this.registerStrigaRepository});

  @override
  Future<Either<Failure, UserInfoResponse>> call(NoParams params) async {
    return await registerStrigaRepository.getUserInfo();
  }
}