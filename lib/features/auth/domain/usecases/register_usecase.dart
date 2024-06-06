import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<void, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      RegisterParams params) async {
    return await repository.register(
      phoneNumber: params.phoneNumber,
      password: params.password,
      level: params.level,
      displayName: params.displayName,
      address: params.address,
      experienceYears: params.experienceYears,
    );
  }
}

class RegisterParams {
  final String phoneNumber;
  final String password;
  String? address;
  final String displayName;
  String? level;
  int? experienceYears;

  RegisterParams(
      {required this.phoneNumber,
        required this.password,
        required this.displayName,
        this.level,
        this.experienceYears,
        this.address});
}
