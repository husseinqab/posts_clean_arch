import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/generic_api_calls.dart';
import 'package:posts_clean_arch/fearutres/users/data/datasources/user_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/users/domain/entities/user.dart';
import 'package:posts_clean_arch/fearutres/users/domain/repositories/user_repository.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final GenericCall callApi;

  UserRepositoryImpl(
      {required this.remoteDataSource, required this.callApi});

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    return await callApi(() => remoteDataSource.getAllUsers());
  }
}
