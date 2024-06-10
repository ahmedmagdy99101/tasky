part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoCreated extends TodoState {}

class TodoError extends TodoState {
  final String message;

  const TodoError({required this.message});

  @override
  List<Object> get props => [message];
}

class TodoFailure extends TodoState {
  final String message;

  const TodoFailure(this.message);

  @override
  List<Object> get props => [message];
}
