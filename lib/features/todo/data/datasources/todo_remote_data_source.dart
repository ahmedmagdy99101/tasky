import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/config/APIs/apis_urls.dart';
import 'package:tasky/config/constants/app_strings.dart';
import '../../../../core/utils/services/remote/dio_helper.dart';
import '../../domain/entities/todo.dart';
import '../models/todo_model.dart';
import 'package:tasky/storage.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> fetchTodos(int page);
  Future<void> addTodo({
    required Todo todo,
  });
  Future<String> uploadImage({
    required XFile imageFile,
  });
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {


  TodoRemoteDataSourceImpl();

  @override
  Future<List<TodoModel>> fetchTodos(int page) async {
    final response = await DioHelper.dio.get(
      ApisStrings.todosUrl,
      queryParameters: {'page':page }
    );

    if (response.statusCode == 200 ||response.statusCode == 201) {
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
    required Todo todo,

  }) async {
    try {
      Response response = await DioHelper.dio.post(
        ApisStrings.todosUrl,

        data: {
          'image': todo.imageUrl ,
          'title': todo.title,
          'desc': todo.description,
          'priority': todo.priority,
          'dueDate': DateFormat('d MMMM, yyyy').format(todo.createdAt).toString(),
        },
      // options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
    final response = await DioHelper.dio.put(
      'https://your-api-url.com/todos/${todo.id}',
      data: todo.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final response = await DioHelper.dio.delete('https://your-api-url.com/todos/$id');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }

  @override
  Future<String> uploadImage({required XFile imageFile}) async {
    String fileName = path.basename(imageFile.path);
    String mimeType = lookupMimeType(imageFile.path) ?? 'application/octet-stream';

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      ),
    });

    try {
      Response response = await DioHelper.dio.post(
        ApisStrings.uploadImageUrl,
       // 'https://todo.iraqsapp.com/upload/image',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppSharedPreferences.getString(key: AppStrings.accessToken)}',
          },
          validateStatus: (status) {
            return status! < 500; // Accept all status codes below 500
          },
        ),
      );

      debugPrint('Response data: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Image uploaded successfully: ${response.data}');
        return response.data['image']; // Adjust according to the actual response structure
      } else {
        debugPrint('Failed to upload image: ${response.data}');
        return 'Error';
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return 'Error';
    }
  }

}
