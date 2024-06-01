import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../error/failures.dart';

/// Abstract class for a use case.
abstract class UseCase<Type, Params> {
  /// Function that executes the use case.
  ///
  /// `Type` is the expected return type of the use case.
  /// `Params` is the type of parameters passed to the use case.
  Future<Either<Failure, Type>> call(Params params);
}
