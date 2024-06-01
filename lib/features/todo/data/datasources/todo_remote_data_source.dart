import 'package:dio/dio.dart';
import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> fetchTodos(int page);
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio dio;

  TodoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TodoModel>> fetchTodos(int page) async {
    final response = await dio.get('https://your-api-url.com/todos?page=$page');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((todo) => TodoModel.fromJson(todo))
          .toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final response = await dio.post(
      'https://your-api-url.com/todos',
      data: todo.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add todo');
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final response = await dio.put(
      'https://your-api-url.com/todos/${todo.id}',
      data: todo.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final response = await dio.delete('https://your-api-url.com/todos/$id');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
