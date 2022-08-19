import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/fearutres/auth/domain/entities/login.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginRepository extends Equatable {
  Future<Either<Failure, bool>> validateUser(LoginEntity loginEntity);
}