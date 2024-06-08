import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/features/profile/domain/repositories/profile_repository.dart';

import '../../domain/entities/profile_model.dart';
import '../datasources/profile_remote_date_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDateSourceImpl remoteDataSource;

  ProfileRepositoryImpl(
      {required this.remoteDataSource});
  @override
  Future<Either<Failure, ProfileModel>> getProfileData() async {
    var response = await remoteDataSource.getProfileData();
    try {
      print("this is From repo ${response}");
      return right(ProfileModel.fromJson(response));
    } catch (e) {
      print("this Exception is ${e.toString()}");
      return Left(ServerFailure(response["message"]));
    }
  }

}
