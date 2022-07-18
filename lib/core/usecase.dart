import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseListing<Type, Params> {
  Future<Either<Failure, List<Type>>> call(Params params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
