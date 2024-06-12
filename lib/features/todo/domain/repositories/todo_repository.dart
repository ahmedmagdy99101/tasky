import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/error/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> fetchTodos(int page);
  Future<Either<Failure, Todo>> addTodo({
    required Todo todo,
  });
  Future<Either<Failure, String>> uploadImage({
    required XFile imageFile,
  });
  Future<Either<Failure, void>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(String id);
}
