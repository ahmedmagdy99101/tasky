import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile_model.dart';
import '../../domain/usecases/profile_date_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileDataUseCase profileDataUseCase;
  ProfileCubit(this.profileDataUseCase) : super(ProfileInitial());
  Future<void> getProfileDataMethod() async {
    emit(ProfileIsLoading());
    var response = await profileDataUseCase.call();
    response.fold(
      (failure) => emit(const ProfileFailure(message: "Some Thing is Wrong")),
      (data) => emit(ProfileIsLoaded(profileModel: data)),
    );
  }
}
