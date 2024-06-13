part of 'update_todo_cubit.dart';

sealed class UpdateTodoState extends Equatable {
  const UpdateTodoState();

  @override
  List<Object> get props => [];
}

final class UpdateTodoInitial extends UpdateTodoState {}

final class UpdateTodoIsLoading extends UpdateTodoState {}

final class UpdateTodoSuccess extends UpdateTodoState {}

final class UpdateTodoFailure extends UpdateTodoState {
  final String message;

  const UpdateTodoFailure({required this.message});
}

class UploadUpdatedImageSuccess extends UpdateTodoState {
  final String imagePath;

  const UploadUpdatedImageSuccess({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class UploadUpdatedImageError extends UpdateTodoState {
  final String message;

  const UploadUpdatedImageError(this.message);

  @override
  List<Object> get props => [message];
}
