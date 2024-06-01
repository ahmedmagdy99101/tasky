import 'package:bloc/bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({required this.loginUseCase, required this.registerUseCase}) : super(AuthInitial());

  Future<void> login(String phoneNumber, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(phoneNumber: phoneNumber, password: password));
    result.fold(
          (failure) => emit(AuthFailure(message: 'Login Failed')),
          (user) => emit(AuthLoaded(user: user)),
    );
  }

  Future<void> register(String phoneNumber, String password) async {
    emit(AuthLoading());
    final result = await registerUseCase(RegisterParams(phoneNumber: phoneNumber, password: password));
    result.fold(
          (failure) => emit(AuthFailure(message: 'Registration Failed')),
          (_) => emit(AuthInitial()),
    );
  }
}
