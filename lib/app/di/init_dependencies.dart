import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky_app/features/auth/login/repositories/login_remote_repository.dart';
import 'package:tasky_app/features/auth/login/viewmodel/login_cubit/login_cubit.dart';
import 'package:tasky_app/features/auth/signup/repositories/signup_remote_repository.dart';
import 'package:tasky_app/features/auth/signup/viewmodel/signup_cubit/signup_cubit.dart';
import 'package:tasky_app/features/create_task/viewmodel/bloc/create_task_bloc.dart';
import 'package:tasky_app/features/home/repositories/home_repository.dart';
import 'package:tasky_app/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:tasky_app/shared/networking/dio_factory.dart';

import '../../features/create_task/repositories/create_task_repository.dart';
import '../../features/delete_task/repositories/delete_task_repository.dart';
import '../../features/profile/repositories/profile_remote_repository.dart';
import '../../features/profile/viewmodel/bloc/profile_bloc.dart';
import '../../features/update_task/repositories/update_task_remote_repository.dart';
import '../../features/update_task/viewmodel/bloc/update_task_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  /// Dio & ApiService
  Dio dio = DioFactory.getDio();
  serviceLocator.registerLazySingleton<Dio>(() => dio);

  /// CORE DEPENDENCIES REGISTRATION STARTS HERE
  _initAuthRegistration();
  _initHomeRegistration();
  _initDeleteTaskRegistration();
  _initCreateTaskRegistration();
  _initProfileRegistration();
  _initUpdateTaskRegistration();
}

void _initAuthRegistration() {
  /// Register Repositories of Auth
  serviceLocator.registerFactory<LoginRemoteRepository>(
    () => LoginRemoteRepository(
      dio: serviceLocator<Dio>(),
    ),
  );
  serviceLocator.registerFactory<SignupRemoteRepository>(
    () => SignupRemoteRepository(
      dio: serviceLocator<Dio>(),
    ),
  );

  /// Register Cubits of Auth
  serviceLocator.registerLazySingleton<LoginCubit>(
    () => LoginCubit(
      loginRemoteRepository: serviceLocator<LoginRemoteRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton<SignupCubit>(
    () => SignupCubit(
      signupRemoteRepository: serviceLocator<SignupRemoteRepository>(),
    ),
  );
}

void _initHomeRegistration() {
  /// Register Repositories of Home
  serviceLocator.registerFactory<HomeRemoteRepository>(
    () => HomeRemoteRepository(
      dio: serviceLocator<Dio>(),
    ),
  );

  /// Register Blocs of Home
  serviceLocator.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      homeRepository: serviceLocator<HomeRemoteRepository>(),
      deleteTaskRemoteRepository: serviceLocator<DeleteTaskRemoteRepository>(),
    ),
  );
}

void _initDeleteTaskRegistration() {
  /// Register Repositories of DeleteTask
  serviceLocator.registerFactory<DeleteTaskRemoteRepository>(
    () => DeleteTaskRemoteRepository(
      dio: serviceLocator<Dio>(),
    ),
  );
}

void _initCreateTaskRegistration() {
  /// Register Repositories of CreateTask
  serviceLocator.registerFactory<CreateTaskRepository>(
    () => CreateTaskRepository(
      dio: serviceLocator<Dio>(),
    ),
  );

  /// Register Blocs of CreateTask
  serviceLocator.registerLazySingleton<CreateTaskBloc>(
    () => CreateTaskBloc(
      createTaskRepository: serviceLocator<CreateTaskRepository>(),
    ),
  );
}

void _initProfileRegistration() {
  /// Register Repositories of Profile
  serviceLocator.registerFactory<ProfileRemoteRepository>(
    () => ProfileRemoteRepository(
      dio: serviceLocator<Dio>(),
    ),
  );

  /// Register Blocs of Profile
  serviceLocator.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(
      profileRemoteRepository: serviceLocator<ProfileRemoteRepository>(),
    ),
  );
}

void _initUpdateTaskRegistration() {
  /// Register Repositories of UpdateTask
  serviceLocator.registerFactory<UpdateTaskRemoteRepository>(
    () => UpdateTaskRemoteRepository(
      dio: serviceLocator<Dio>(),
    ),
  );

  /// Register Blocs of UpdateTask
  serviceLocator.registerLazySingleton<UpdateTaskBloc>(
    () => UpdateTaskBloc(
      updateTaskRemoteRepository: serviceLocator<UpdateTaskRemoteRepository>(),
      createTaskRepository: serviceLocator<CreateTaskRepository>(),
    ),
  );
}
