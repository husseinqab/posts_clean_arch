import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/fearutres/users/domain/entities/user.dart';

import '../../../../core/errors/failure.dart';

abstract class UserRepository {
  Future<Either<Failure,List<User>>> getAllUsers();
}