import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:tasky/features/profile/domain/repositories/profile_repository.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/profile/data/datasources/profile_remote_date_source.dart';
import 'features/profile/data/repositories/profile_date_repo_imple.dart';
import 'features/profile/domain/usecases/profile_date_use_case.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/todo/data/datasources/todo_remote_data_source.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/usecases/get_todos_usecase.dart';
import 'features/todo/presentation/cubit/todo_cubit.dart';

final sl = GetIt.instance;

void setup()  {
  // External
  sl.registerLazySingleton<Dio>(() => Dio());

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSourceImpl>(
          () => AuthRemoteDataSourceImpl(dio: sl.get<Dio>()));
  sl.registerLazySingleton<TodoRemoteDataSourceImpl>(
          () => TodoRemoteDataSourceImpl(dio: sl.get<Dio>()));
  sl.registerLazySingleton<ProfileRemoteDateSourceImpl>(
          () => ProfileRemoteDateSourceImpl(dio: sl.get<Dio>()));

  // Repositories
  sl.registerLazySingleton<AuthRepositoryImpl>(() =>
      AuthRepositoryImpl(remoteDataSource: sl.get<AuthRemoteDataSourceImpl>()));
  sl.registerLazySingleton<TodoRepositoryImpl>(() =>
      TodoRepositoryImpl(remoteDataSource: sl.get<TodoRemoteDataSourceImpl>()));
  sl.registerLazySingleton<ProfileRepositoryImpl>(() =>
      ProfileRepositoryImpl(remoteDataSource: sl.get<ProfileRemoteDateSourceImpl>() ));

  // Use Cases
  sl.registerLazySingleton(
          () => LoginUseCase(repository: sl.get<AuthRepositoryImpl>()));
  sl.registerLazySingleton(
          () => RegisterUseCase(repository: sl.get<AuthRepositoryImpl>()));
  sl.registerLazySingleton(
          () => GetTodosUseCase(repository: sl.get<TodoRepositoryImpl>()));
  sl.registerLazySingleton(() =>
      ProfileDataUseCase(repository: sl.get<ProfileRepositoryImpl>()));

  // Cubits
  sl.registerFactory(() => AuthCubit(
    loginUseCase: sl.get<LoginUseCase>(),
    registerUseCase: sl.get<RegisterUseCase>(),
  ));
  sl.registerFactory(() => TodoCubit(repository: sl.get<TodoRepositoryImpl>()));
  sl.registerFactory(() => ProfileCubit(sl.get<ProfileDataUseCase>()));
}
