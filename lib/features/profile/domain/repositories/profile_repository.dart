import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';

import '../entities/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfileData();
}
