import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String phoneNumber, String password);
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String phoneNumber,
    required String password,
    required String displayName,
    int? experienceYears,
    String? level,
    String? address,
  });
}
