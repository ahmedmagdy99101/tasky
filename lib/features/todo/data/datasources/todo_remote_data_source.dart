import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/todo_model.dart';
import 'package:tasky/storage.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> fetchTodos(int page);
  Future<void> addTodo({
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
    required XFile imageFile,
  });
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio dio;

  TodoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TodoModel>> fetchTodos(int page) async {
    final response = await dio.get(
      'https://todo.iraqsapp.com/todos',
      options: Options(
        headers: {
          'Authorization':
          'Bearer ${AppSharedPreferences.sharedPreferences.getString("accessToken")}',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.data);
      return (response.data as List)
          .map((todo) => TodoModel.fromJson(todo))
          .toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  Future<void> addTodo({
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
    required XFile imageFile,
  }) async {
    // String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      'image': imageFile
          .path /* await MultipartFile.fromFile(imageFile.path, filename: fileName) */,
      'title': title,
      'desc': desc,
      'priority': priority,
      'dueDate': dueDate,
    });

    // Set the headers
    Options options = Options(
      headers: {
        'Authorization':
        'Bearer ${AppSharedPreferences.sharedPreferences.getString("accessToken")}',
      },
    );

    try {
      Response response = await dio.post(
        'https://todo.iraqsapp.com/todos',
        data: {
          'image': imageFile
              .path /* await MultipartFile.fromFile(imageFile.path, filename: fileName) */,
          'title': title,
          'desc': desc,
          'priority': priority,
          'dueDate': dueDate,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        debugPrint('Todo posted successfully: ${response.data}');
      } else {
        debugPrint('Failed to post todo: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error posting todo: $e');
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
