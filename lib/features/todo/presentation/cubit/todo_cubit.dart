import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/get_todos_usecase.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final TodoRepository repository;
  static late List<Todo> waitingList;
  static late List<Todo> finishedList;
  static late List<Todo> inProgressList;
  static PagingController<int, Todo> pagingController =
  PagingController(firstPageKey: 1);
  TodoCubit({
    required this.repository,
  })  : getTodosUseCase = GetTodosUseCase(repository: repository),
        super(TodoInitial());

  void loadTodos(int page) async {
    waitingList = [];
    finishedList = [];
    inProgressList = [];
    emit(TodoLoading());
    final failureOrTodos = await getTodosUseCase(
        GetTodosParams(page: page)); // Pass parameters here
    failureOrTodos.fold(
          (failure) => emit(const TodoError(message: 'Failed to fetch todos')),
          (todos) {
        final isLastPage = todos.length < 20;
        if (isLastPage) {
          pagingController.appendLastPage(todos);
        } else {
          final nextPageKey = page + todos.length;
          pagingController.appendPage(todos, nextPageKey);
        }
        for (var element in todos) {
          if (element.status == "waiting") {
            waitingList.add(element);
          } else if (element.status == "inprogress") {
            inProgressList.add(element);
          } else {
            finishedList.add(element);
          }
        }

        emit(TodoLoaded(todos: todos));
      },
    );
  }

  void addTodo({
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
    required XFile imageFile,
  }) async {
    var response = await repository.addTodo(
      title: title,
      desc: desc,
      priority: priority,
      dueDate: dueDate,
      imageFile: imageFile,
    );
    response.fold(
          (l) => emit(const TodoFailure("some thing in wrong")),
          (r) => emit(TodoCreated()),
    );
  }
}


// class TodoCubit extends Cubit<TodoState> {
//   final GetTodosUseCase getTodosUseCase;
//
//   TodoCubit({required TodoRepository repository})
//       : getTodosUseCase = GetTodosUseCase(repository: repository),
//         super(TodoInitial());
//
//   void loadTodos(int page) async {
//     emit(TodoLoading());
//     final failureOrTodos = await getTodosUseCase(GetTodosParams(page: page)); // Pass parameters here
//     failureOrTodos.fold(
//           (failure) => emit(const TodoError(message: 'Failed to fetch todos')),
//           (todos) => emit(TodoLoaded(todos: todos)),
//     );
//   }
//
//   void addTodo(Todo todo) {
//     final currentState = state;
//     if (currentState is TodoLoaded) {
//       final updatedTodos = [...currentState.todos, todo];
//       emit(TodoLoaded(todos: updatedTodos));
//     } else {
//       emit(const TodoError(message: 'Cannot add todo at the moment.'));
//     }
//   }
// }
