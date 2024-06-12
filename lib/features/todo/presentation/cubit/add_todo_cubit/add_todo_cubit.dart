import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/repositories/todo_repository.dart';
import '../../../domain/usecases/add_todo_usecase.dart';

part 'add_todo_state.dart';

class CreateTodoCubit extends Cubit<AddTodoState> {
  final AddTodoUseCase addTodoUseCase;
  final TodoRepository repository;
  CreateTodoCubit({
     required this.repository,
  })  : addTodoUseCase = AddTodoUseCase(repository: repository),
        super(CreateTodoInitial());


  void addTodo({
    required Todo todo,
  }) async {
    emit(CreateTodoLoading());
    var response = await repository.addTodo(
     todo: todo,
    );
    response.fold(
          (l) => emit(const CreateTodoError( message: 'حدث خطأ أثناء حفظ البيانات')),
          (r) => emit(const CreateTodoSuccess(message: 'تم إنشاء التاسك بنجاح')),
    );
  }

  void uploadImage({required XFile imageFile}) async {
    var response = await repository.uploadImage(imageFile: imageFile);
    response.fold(
          (l) => emit(const UploadImageError("some thing in wrong")),
          (r) => emit( UploadImageSuccess(imagePath: r)),
    );
  }

}


