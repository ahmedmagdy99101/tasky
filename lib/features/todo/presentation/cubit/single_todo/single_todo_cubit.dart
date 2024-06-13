import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/features/todo/domain/entities/todo.dart';
import 'package:tasky/features/todo/domain/repositories/todo_repository.dart';

part 'single_todo_state.dart';

class SingleTodoCubit extends Cubit<SingleTodoState> {
  final TodoRepository repository;
  SingleTodoCubit(this.repository) : super(SingleTodoInitial());
  Future<void> fetchSingleTodo(String id) async {
    var response = await repository.fetchSingleTodos(id);
    response.fold(
      (failure) => emit(SingleTodoFailure(message: "أعد قراءة الباركود")),
      (todo) => emit(SingleTodoSuccess(todo: todo)),
    );
  }
}
