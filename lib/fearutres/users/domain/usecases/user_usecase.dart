import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/users/domain/repositories/user_repository.dart';

import '../entities/user.dart';

class GetAllUsers extends UseCaseListing<User,NoParams>{
  final UserRepository userRepository;

  GetAllUsers({required this.userRepository});
  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await userRepository.getAllUsers();
  }

}