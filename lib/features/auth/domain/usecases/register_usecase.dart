import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<void, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    return await repository.register(params.phoneNumber, params.password);
  }
}

class RegisterParams {
  final String phoneNumber;
  final String password;

  RegisterParams({required this.phoneNumber, required this.password});
}
