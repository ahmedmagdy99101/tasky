import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/features/todo/domain/entities/todo.dart';
import 'package:tasky/features/todo/domain/repositories/todo_repository.dart';

part 'update_todo_state.dart';

class UpdateTodoCubit extends Cubit<UpdateTodoState> {
  final TodoRepository repository;
  UpdateTodoCubit(this.repository) : super(UpdateTodoInitial());
  void updateTodo({
    required Todo todo,
  }) async {
    emit(UpdateTodoIsLoading());
    var response = await repository.updateTodo(
      todo,
    );
    response.fold(
      (l) =>
          emit(const UpdateTodoFailure(message: 'حدث خطأ أثناء حفظ البيانات')),
      (r) => emit(UpdateTodoSuccess()),
    );
  }

  void uploadImage({required XFile imageFile}) async {
    var response = await repository.uploadImage(imageFile: imageFile);
    response.fold(
      (l) => emit(const UploadUpdatedImageError("some thing in wrong")),
      (r) => emit(UploadUpdatedImageSuccess(imagePath: r)),
    );
  }
}
