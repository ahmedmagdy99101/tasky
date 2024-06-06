import 'package:dartz/dartz.dart';
import 'package:tasky/features/auth/data/repositories/auth_repository_impl.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepositoryImpl repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.phoneNumber, params.password);
  }
}

class LoginParams {
  final String phoneNumber;
  final String password;

  LoginParams({required this.phoneNumber, required this.password});
}
