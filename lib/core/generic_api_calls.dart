import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/network/network_info.dart';

import 'errors/exception.dart';
import 'errors/failure.dart';

class GenericCall {
  final NetworkInfo networkInfo;

  GenericCall({required this.networkInfo});

  Future<Either<Failure,T>> call<T>(Future<T> Function() call) async {
    if (await networkInfo.isConnected){
      try {
        final response = await call();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAurhtorizedFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      } on UnExpectedException {
        return Left(UnExpectedFailure());
      } on DWApiException catch (e) {
        return Left(DWApiFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

}