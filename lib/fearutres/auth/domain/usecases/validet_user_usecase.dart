import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/auth/domain/entities/login.dart';
import 'package:posts_clean_arch/fearutres/auth/domain/repositories/login_reposiotry.dart';

class ValidateUserUsecase extends UseCase<bool,LoginEntity> {
  final LoginRepository loginRepository;

  ValidateUserUsecase({required this.loginRepository});

  @override
  Future<Either<Failure, bool>> call(LoginEntity params) async {
    return  await loginRepository.validateUser(params);
  }


}