import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String phoneNumber, String password) async {
    try {
      final result = await remoteDataSource.login(phoneNumber, password);
      return Right(User.fromJson(result));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register(String phoneNumber, String password) async {
    try {
      await remoteDataSource.register(phoneNumber, password);
      return Right(null);  // هتستقبل هنا ال  displayName  -  access_token -  refresh_token
    } catch (e) {
      return Left(ServerFailure()); // Handle error
    }
  }
}
