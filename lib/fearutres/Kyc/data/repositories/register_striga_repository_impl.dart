import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/fearutres/Kyc/data/datasources/register_striga_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/regsiter_striga_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/verify_email_request.dart';

import '../../../../core/generic_api_calls.dart';
import '../../domain/repositories/register_striga_repository.dart';

class RegisterStrigaRepositoryImpl extends RegisterStrigaRepository {
  final RegisterStrigaDataSource remoteDataSource;
  final GenericCall callApi;

  RegisterStrigaRepositoryImpl({required this.remoteDataSource,required this.callApi});

  @override
  Future<Either<Failure, RegisterStrigaResponse>> registerStriga(RegisterStrigaRequest request) async {
    return await callApi(() => remoteDataSource.registerInStriga(request));
  }

  @override
  Future<Either<Failure, String>> verifyEmailStriga(VerifyEmailRequest request) async {
    return await callApi(() => remoteDataSource.verifyEmailStriga(request));

  }
}
