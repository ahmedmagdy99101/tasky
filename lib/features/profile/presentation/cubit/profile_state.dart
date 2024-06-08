part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileIsLoading extends ProfileState {}

final class ProfileIsLoaded extends ProfileState {
  final ProfileModel profileModel;

  const ProfileIsLoaded({required this.profileModel});
}

final class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure({required this.message});
}
