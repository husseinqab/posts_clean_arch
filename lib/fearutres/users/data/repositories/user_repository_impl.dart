import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/fearutres/users/data/datasources/user_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/users/domain/entities/user.dart';
import 'package:posts_clean_arch/fearutres/users/domain/repositories/user_repository.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAllUsers();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
