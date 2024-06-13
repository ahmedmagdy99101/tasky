part of 'single_todo_cubit.dart';

sealed class SingleTodoState extends Equatable {
  const SingleTodoState();

  @override
  List<Object> get props => [];
}

final class SingleTodoInitial extends SingleTodoState {}

final class SingleTodoIsLoading extends SingleTodoState {}

final class SingleTodoSuccess extends SingleTodoState {
  final Todo todo;

  SingleTodoSuccess({required this.todo});
}

final class SingleTodoFailure extends SingleTodoState {
  final String message;

  SingleTodoFailure({required this.message});
}
