import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../data/models/widget_state.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/get_todos_usecase.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final TodoRepository repository;
  List<Todo> allTodos = [];
  List<Todo> get inProgressList =>allTodos.where((element) => element.status == 'inprogress',).toList();
  List<Todo> get waitingList =>allTodos.where((element) => element.status == 'waiting',).toList();
  List<Todo> get finishedList =>allTodos.where((element) => element.status == 'finished',).toList();

   PagingController<int, Todo> pagingController =
  PagingController(firstPageKey: 1);
  TodoCubit({
    required this.repository,
  })  : getTodosUseCase = GetTodosUseCase(repository: repository),
        super(TodoInitial());


  void loadTodos(int page) async {
    if (page == 1) {
      emit(TodoLoading());
      allTodos = [];
      pagingController.refresh();
    }


    final failureOrTodos = await getTodosUseCase(GetTodosParams(page: page));
    failureOrTodos.fold(
          (failure) => emit(const TodoError(message: 'Failed to fetch todos')),
          (todos) {
        final isLastPage = todos.length < 20;
        if (isLastPage) {
          allTodos.addAll(todos);
          pagingController.appendLastPage(todos);
        } else {
          final nextPageKey = page + 1;
          allTodos.addAll(todos);
          pagingController.appendPage(todos, nextPageKey);
        }
        emit(TodoLoaded(todos: todos));
      },
    );
  }

  Future<void> deleteTodoMethod(String id) async {
    try {
      emit(DeleteTodoIsLoading());
      var response = await repository.deleteTodo(id);
      response.fold(
            (failure) => emit(DeleteTodoFailure(message: failure.message)),
            (r) => emit(DeleteTodoSuccess()),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  Future<void> logout() async {
    try {

      var response = await repository.logout();
      response.fold(
            (failure) => emit(LogoutFailure(message: failure.message)),
            (r) => emit(LogoutSuccess()),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}

/*
  ScrollController scrollController = ScrollController();

  int page = 1;

  int maxValue = 20;

  int maxProducts = 20;

  CustomWidgetState getAlTodosState = CustomWidgetState.none;
  CustomWidgetState loadMoreTodosState = CustomWidgetState.none;

  void loadTodos() async {
    getAlTodosState = CustomWidgetState.loading;
    emit(GetAllProductsLoadingState());
    await DioHelper.dio.get("Product/GetAvailableProductsView/$page/10").then((
        value) {
      //  allTodos.clear();
      allTodos.addAll((value.data ?? [])
          .map<Todo>((e) => Todo.fromJson(e))
          .toList());

      page++;
      print(allTodos);
      emit(GetAllProductsSuccessState());
      getAlTodosState = CustomWidgetState.success;
    }).catchError((onError) {
      getAlTodosState = CustomWidgetState.error;
      emit(GetAllProductsErrorState());
    });
  }

  bool isLoadMoreData = true;

  void loadMoreData() async {
    print(page);
    if (isLoadMoreData) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (loadMoreDataState != CustomWidgetState.loading &&
            getAlTodosState != CustomWidgetState.loading) {
          loadMoreDataState = CustomWidgetState.loading;
          emit(GetMoreProductsLoadingState());
          await DioHelper.dio.get(
              "Product/GetAvailableProductsView/$page/$maxValue").then((value) {
            //  allTodos.clear();
            allTodos.addAll((value.data ?? []).map<Todo>((e) =>
                Todo.fromJson(e)).toList());

            page++;
            maxProducts = (value.data ?? [])
                .map<Todo>((e) => Todo.fromJson(e))
                .toList()
                .length;

            print(allTodos);
            print("loadmore: ${(value.data ?? [])
                .map<Todo>((e) => Todo.fromJson(e))
                .toList()
                .length} ");
            emit(GetMoreProductsSuccessState());
            loadMoreDataState = CustomWidgetState.success;
          });
        }
        if (maxProducts < maxValue) {
          isLoadMoreData = false;
        }
      }
    }
  }
 */

