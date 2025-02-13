import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/network/api_service.dart';
import 'package:koselie/core/network/hive_service.dart';
import 'package:koselie/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:koselie/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:koselie/features/auth/data/repository/auth_local_repository.dart';
import 'package:koselie/features/auth/data/repository/auth_remote_repository.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:koselie/features/category/data/data_source/local_datasource/category_local_data_source.dart';
import 'package:koselie/features/category/data/data_source/remote_datasource/category_remote_data_source.dart';
import 'package:koselie/features/category/data/repository/category_local_repository.dart';
import 'package:koselie/features/category/data/repository/category_remote_repository.dart';
import 'package:koselie/features/category/domain/usecase/create_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/delete_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/get_all_category_usecase.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';
import 'package:koselie/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initSharedPreferences();
  await _initCategoryDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
// =========================== Data Source ===========================
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>()),
  );
  // =========================== Repository ===========================
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );
  // =========================== Usecases ===========================
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(), // only for testing
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

_initCategoryDependencies() async {
  // =========================== Data Source ===========================
  getIt.registerFactory<CategoryLocalDataSource>(
      () => CategoryLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton<CategoryLocalRepository>(() =>
      CategoryLocalRepository(
          categoryLocalDataSource: getIt<CategoryLocalDataSource>()));

  getIt.registerLazySingleton(
    () => CategoryRemoteRepository(
      remoteDataSource: getIt<CategoryRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<CreateCategoryUseCase>(
    () => CreateCategoryUseCase(
        categoryRepository: getIt<CategoryRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllCategoryUseCase>(
    () => GetAllCategoryUseCase(
        categoryRepository: getIt<CategoryRemoteRepository>()),
  );

  getIt.registerLazySingleton<DeleteCategoryUsecase>(
    () => DeleteCategoryUsecase(
      categoryRepository: getIt<CategoryRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      createCategoryUseCase: getIt<CreateCategoryUseCase>(),
      getAllCategoryUseCase: getIt<GetAllCategoryUseCase>(),
      deleteCategoryUsecase: getIt<DeleteCategoryUsecase>(),
    ),
  );
}
