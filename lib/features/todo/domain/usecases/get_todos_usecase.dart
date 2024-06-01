import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosUseCase implements UseCase<List<Todo>, GetTodosParams> {
  final TodoRepository repository;

  GetTodosUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(GetTodosParams params) async {
    return await repository.fetchTodos(params.page);
  }
}

class GetTodosParams {
  final int page;

  GetTodosParams({required this.page});
}
