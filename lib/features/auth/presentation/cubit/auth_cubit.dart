import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({required this.loginUseCase, required this.registerUseCase})
      : super(AuthInitial());

  Future<void> login(String phoneNumber, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(
        LoginParams(phoneNumber: phoneNumber, password: password));
    result.fold(
          (failure) => emit(AuthFailure(message: 'Login Failed')),
          (user) => emit(AuthLoaded(user: user)),
    );
  }

  Future<void> register({
    required String phoneNumber,
    required String password,
    required String displayName,
    int? experienceYears,
    String? level,
    String? address,
  }) async {
    emit(AuthLoading());
    final result = await registerUseCase(RegisterParams(
      phoneNumber: phoneNumber,
      password: password,
      displayName: displayName,
      level: level,
      experienceYears: experienceYears,
      address: address,
    ));
    result.fold(
          (failure) => emit(AuthFailure(message: 'Registration Failed')),
          (data) => emit(AuthLoaded(user: data)),
    );
  }
}
