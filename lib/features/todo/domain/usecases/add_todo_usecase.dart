import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';


class AddTodoUseCase implements UseCase<Todo, CreateTodosParams> {
  final TodoRepository repository;

  AddTodoUseCase({required this.repository});

  @override
  Future<Either<Failure, Todo>> call(CreateTodosParams params) async {
    return await repository.addTodo(todo: params.todo);

  }
}

class CreateTodosParams {
  final Todo todo;

  CreateTodosParams({required this.todo});
}