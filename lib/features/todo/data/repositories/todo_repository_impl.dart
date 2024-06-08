import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Todo>>> fetchTodos(int page) async {
    try {
      final result = await remoteDataSource.fetchTodos(page);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      await remoteDataSource.addTodo(TodoModel(
        id: todo.id,
        imageUrl: todo.imageUrl,
        title: todo.title,
        description: todo.description,
        priority: todo.priority,
        status: todo.status,
        user: todo.user,
        createdAt: todo.createdAt,
        updatedAt: todo.updatedAt,
      ));
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      await remoteDataSource.updateTodo(TodoModel(
        id: todo.id,
        imageUrl: todo.imageUrl,
        title: todo.title,
        description: todo.description,
        priority: todo.priority,
        status: todo.status,
        user: todo.user,
        createdAt: todo.createdAt,
        updatedAt: todo.updatedAt,
      ));
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await remoteDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(""));
    }
  }
}
