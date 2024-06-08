import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/profile_date_repo_imple.dart';
import '../entities/profile_model.dart';

class ProfileDataUseCase implements UseCaseWithoutParams<ProfileModel> {
  final ProfileRepositoryImpl repository;

  const ProfileDataUseCase({ required this.repository});

  @override
  Future<Either<Failure, ProfileModel>> call() async {
    var response = await repository.getProfileData();
    response.fold((l) => print("any Thing"), (r) => print(r.username));

    return response;
  }
}
