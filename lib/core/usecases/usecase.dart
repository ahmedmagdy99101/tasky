import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Abstract class for a use case.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}