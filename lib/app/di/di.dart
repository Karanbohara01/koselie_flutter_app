import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:koselie/core/network/api_service.dart';
import 'package:koselie/core/network/hive_service.dart';
import 'package:koselie/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:koselie/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:koselie/features/auth/data/repository/auth_local_repository.dart';
import 'package:koselie/features/auth/data/repository/auth_remote_repository.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';
import 'package:koselie/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

// Remote Data source
_initApiService() async {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // Remote data source
  getIt.registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(getIt<Dio>()));

// Remote Repository
  getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()));

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register  usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
