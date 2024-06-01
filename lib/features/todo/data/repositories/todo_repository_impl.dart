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
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      await remoteDataSource.addTodo(TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        completed: todo.completed,
        imageUrl: todo.imageUrl,
      ));
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      await remoteDataSource.updateTodo(TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        completed: todo.completed,
        imageUrl: todo.imageUrl,
      ));
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await remoteDataSource.deleteTodo(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
