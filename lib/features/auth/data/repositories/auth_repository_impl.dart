import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(
      String phoneNumber, String password) async {
    final result = await remoteDataSource.login(phoneNumber, password);
    try {

      debugPrint(
          "this repo ${User.fromJson(result).phoneNumber}   ${User.fromJson(result).token}");
      return Right(User.fromJson(result));
    } catch (e) {
      return Left(ServerFailure(result["message"]));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String phoneNumber,
    required String password,
    required String displayName,
    int? experienceYears,
    String? level,
    String? address,
  }) async {
    final response = await remoteDataSource.register(
      phoneNumber: phoneNumber,
      password: password,
      displayName: displayName,
      level: level,
      experienceYears: experienceYears,
      address: address,
    );
    try {

      debugPrint("$response");
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(response["message"])); // Ha
    }
  }
}
