part of 'add_todo_cubit.dart';

abstract class AddTodoState extends Equatable {
  const AddTodoState();

  @override
  List<Object> get props => [];
}

class CreateTodoInitial extends AddTodoState {}

class CreateTodoLoading extends AddTodoState {}

class CreateTodoSuccess extends AddTodoState {
  final String message;

  const CreateTodoSuccess({required this.message});

  @override
  List<Object> get props => [message];
}


class CreateTodoError extends AddTodoState {
  final String message;

  const CreateTodoError({required this.message});

  @override
  List<Object> get props => [message];
}

class UploadImageSuccess extends AddTodoState {
  final String imagePath;

  const UploadImageSuccess({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class UploadImageError extends AddTodoState {
  final String message;

  const UploadImageError(this.message);

  @override
  List<Object> get props => [message];
}
