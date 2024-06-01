import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/get_todos_usecase.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodosUseCase getTodosUseCase;

  TodoCubit({required TodoRepository repository})
      : getTodosUseCase = GetTodosUseCase(repository: repository),
        super(TodoInitial());

  void loadTodos(int page) async {
    emit(TodoLoading());
    final failureOrTodos = await getTodosUseCase(GetTodosParams(page: page)); // Pass parameters here
    failureOrTodos.fold(
          (failure) => emit(const TodoError(message: 'Failed to fetch todos')),
          (todos) => emit(TodoLoaded(todos: todos)),
    );
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final updatedTodos = [...currentState.todos, todo];
      emit(TodoLoaded(todos: updatedTodos));
    } else {
      emit(const TodoError(message: 'Cannot add todo at the moment.'));
    }
  }
}
