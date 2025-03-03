import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/network/api_service.dart';
import 'package:koselie/core/network/hive_service.dart';
import 'package:koselie/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:koselie/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:koselie/features/auth/data/repository/auth_local_repository.dart';
import 'package:koselie/features/auth/data/repository/auth_remote_repository.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';
import 'package:koselie/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/get_all_users_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/logout_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/update_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:koselie/features/category/data/data_source/local_datasource/category_local_data_source.dart';
import 'package:koselie/features/category/data/data_source/remote_datasource/category_remote_data_source.dart';
import 'package:koselie/features/category/data/repository/category_local_repository.dart';
import 'package:koselie/features/category/data/repository/category_remote_repository.dart';
import 'package:koselie/features/category/domain/usecase/create_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/delete_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/get_all_category_usecase.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/chat/data/data_source/remote_data_source/chat_remote_data_source.dart';
import 'package:koselie/features/chat/data/repository/chat_remote_repository/chat_remote_repository.dart';
import 'package:koselie/features/chat/domain/usecase/delete_message_usecase.dart';
import 'package:koselie/features/chat/domain/usecase/get_message_usecase.dart';
import 'package:koselie/features/chat/domain/usecase/send_message_usecase.dart';
import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';
import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';
import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart';
import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
import 'package:koselie/features/posts/data/repository/posts_remote_repository.dart';
import 'package:koselie/features/posts/domain/usecase/create_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/delete_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_all_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_post_by_id_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/upload_posts_image_usecase.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/posts/service/connectivity_service.dart';
import 'package:koselie/features/sensor/data/datasources/sensor_local_data_source.dart';
import 'package:koselie/features/sensor/data/repositories/sensor_repository_impl.dart';
import 'package:koselie/features/sensor/domain/repositories/sensor_repository.dart';
import 'package:koselie/features/sensor/domain/usecases/detect_shake_usecase.dart';
import 'package:koselie/features/sensor/presentation/bloc/sensor_bloc.dart';
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
  await _initPostsDependencies();
  await _initAuthDependencies();
  await _initChatDependencies();
  await _initSensorDependencies(); // ✅ Register Sensor Dependencies
}

Future<void> _initSensorDependencies() async {
  if (!getIt.isRegistered<SensorLocalDataSource>()) {
    getIt.registerLazySingleton<SensorLocalDataSource>(
      () => SensorLocalDataSourceImpl(),
    );
  }

  if (!getIt.isRegistered<SensorRepository>()) {
    getIt.registerLazySingleton<SensorRepository>(
      () =>
          SensorRepositoryImpl(localDataSource: getIt<SensorLocalDataSource>()),
    );
  }

  if (!getIt.isRegistered<DetectShake>()) {
    getIt.registerLazySingleton<DetectShake>(
      () => DetectShake(repository: getIt<SensorRepository>()),
    );
  }

  if (!getIt.isRegistered<SensorBloc>()) {
    getIt.registerFactory<SensorBloc>(
      () => SensorBloc(
        detectShake: getIt<DetectShake>(),
        authBloc: getIt<AuthBloc>(), // ✅ Ensure `AuthBloc` is registered
      ),
    );
  }
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
    () => AuthRemoteDatasource(
        getIt<Dio>(), getIt<TokenSharedPrefs>()), // ✅ Inject TokenSharedPrefs
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
  // =========================== Register IAuthRepository First ===========================
  if (!getIt.isRegistered<AuthRemoteDatasource>()) {
    getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(
          getIt<Dio>(), getIt<TokenSharedPrefs>()), // ✅ Inject TokenSharedPrefs
    );
  }

  if (!getIt.isRegistered<IAuthRepository>()) {
    getIt.registerLazySingleton<IAuthRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
    );
  }

  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<IAuthRepository>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<UpdateUserUsecase>(
    // ✅ FIX: Register UpdateUserUseCase
    () => UpdateUserUsecase(getIt<IAuthRepository>(),
        authRepository: getIt<IAuthRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  if (!getIt.isRegistered<ForgotPasswordUseCase>()) {
    getIt.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt<IAuthRepository>()),
    );
  }

  if (!getIt.isRegistered<ResetPasswordUseCase>()) {
    getIt.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(getIt<IAuthRepository>()),
    );
  }

  // =========================== Bloc ===========================
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      updateUserUseCase: getIt<UpdateUserUsecase>(),
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
      resetPasswordUseCase:
          getIt<ResetPasswordUseCase>(), // ✅ Inject UpdateUserUseCase
    ),
  );
}

Future<void> _initSplashScreenDependencies() async {
  if (!getIt.isRegistered<SplashCubit>()) {
    getIt.registerFactory<SplashCubit>(
      () => SplashCubit(
        getIt<TokenSharedPrefs>(), // ✅ Inject Token Storage
        getIt<SharedPreferences>(), // ✅ Inject SharedPreferences
      ),
    );
  }
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
      connectivityService: getIt<ConnectivityService>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<CreateCategoryUseCase>(
    () => CreateCategoryUseCase(
        categoryRepository: getIt<CategoryRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
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

// _initPostsDependencies() async {
//   // =========================== Data Source ===========================
//   getIt.registerFactory<PostsLocalDataSource>(
//       () => PostsLocalDataSource(hiveService: getIt<HiveService>()));

//   getIt.registerLazySingleton<PostsRemoteDataSource>(
//     () => PostsRemoteDataSource(getIt<Dio>()),
//   );

//   // =========================== Repository ===========================
//   getIt.registerLazySingleton<PostsLocalRepository>(
//     () => PostsLocalRepository(
//         postsLocalDataSource: getIt<PostsLocalDataSource>()),
//   );

//   // =========================== Usecases ===========================
//   getIt.registerLazySingleton<CreatePostsUseCase>(
//     () => CreatePostsUseCase(
//       postsRepository: getIt<PostsRemoteRepository>(),
//       tokenSharedPrefs: getIt<TokenSharedPrefs>(),
//     ),
//   );
//   // =========================== Use Cases ===========================
//   getIt.registerLazySingleton<UpdatePostsUsecase>(
//     () => UpdatePostsUsecase(
//       postsRepository: getIt<PostsRemoteRepository>(),
//       tokenSharedPrefs: getIt<TokenSharedPrefs>(),
//     ),
//   );

//   getIt.registerLazySingleton<GetPostByIdUseCase>(
//     () => GetPostByIdUseCase(postsRepository: getIt<PostsRemoteRepository>()),
//   );

//   getIt.registerLazySingleton<UploadPostsImageUsecase>(
//     () => UploadPostsImageUsecase(getIt<PostsRemoteRepository>()),
//   );

//   getIt.registerLazySingleton<GetAllPostsUseCase>(
//     () => GetAllPostsUseCase(postRepository: getIt<PostsRemoteRepository>()),
//   );

//   getIt.registerLazySingleton<DeletePostsUsecase>(
//     () => DeletePostsUsecase(
//       postsRepository: getIt<PostsRemoteRepository>(),
//       tokenSharedPrefs: getIt<TokenSharedPrefs>(),
//     ),
//   );

//   // =========================== Bloc ===========================
//   getIt.registerFactory<PostsBloc>(
//     () => PostsBloc(
//       createPostsUseCase: getIt<CreatePostsUseCase>(),
//       getAllPostsUseCase: getIt<GetAllPostsUseCase>(),
//       uploadPostsImageUsecase: getIt<UploadPostsImageUsecase>(),
//       categoryBloc: getIt<CategoryBloc>(),
//       getPostByIdUseCase: getIt<GetPostByIdUseCase>(),
//       deletePostUseCase: getIt<DeletePostsUsecase>(),
//       updatePostsUseCase: getIt<UpdatePostsUsecase>(),
//     ),
//   );
// }

_initPostsDependencies() async {
  // =========================== Data Source ===========================
  getIt.registerFactory<PostsLocalDataSource>(
      () => PostsLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton<PostsRemoteRepository>(
    // Changed from PostsLocalRepository
    () => PostsRemoteRepository(
      remoteDataSource: getIt<PostsRemoteDataSource>(),
      localDataSource:
          getIt<PostsLocalDataSource>(), // Inject local data source
      connectivityService:
          getIt<ConnectivityService>(), // Inject connectivity service
    ),
  );

  getIt.registerLazySingleton<ConnectivityService>(
    // Register Connectivity Service
    () => ConnectivityService(),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<CreatePostsUseCase>(
    () => CreatePostsUseCase(
      postsRepository: getIt<PostsRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
  // =========================== Use Cases ===========================
  getIt.registerLazySingleton<UpdatePostsUsecase>(
    () => UpdatePostsUsecase(
      postsRepository: getIt<PostsRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<GetPostByIdUseCase>(
    () => GetPostByIdUseCase(postsRepository: getIt<PostsRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadPostsImageUsecase>(
    () => UploadPostsImageUsecase(getIt<PostsRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllPostsUseCase>(
    () => GetAllPostsUseCase(postRepository: getIt<PostsRemoteRepository>()),
  );

  getIt.registerLazySingleton<DeletePostsUsecase>(
    () => DeletePostsUsecase(
      postsRepository: getIt<PostsRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<PostsBloc>(
    () => PostsBloc(
      createPostsUseCase: getIt<CreatePostsUseCase>(),
      getAllPostsUseCase: getIt<GetAllPostsUseCase>(),
      uploadPostsImageUsecase: getIt<UploadPostsImageUsecase>(),
      categoryBloc: getIt<CategoryBloc>(),
      getPostByIdUseCase: getIt<GetPostByIdUseCase>(),
      deletePostUseCase: getIt<DeletePostsUsecase>(),
      updatePostsUseCase: getIt<UpdatePostsUsecase>(),
      connectivityService: getIt<ConnectivityService>(),
    ),
  );
}

Future<void> _initChatDependencies() async {
  if (!getIt.isRegistered<ChatRemoteDataSource>()) {
    getIt.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSource(getIt<Dio>()),
    );
  }

  if (!getIt.isRegistered<ChatRemoteRepository>()) {
    getIt.registerLazySingleton<ChatRemoteRepository>(
      () => ChatRemoteRepository(
        getIt<ChatRemoteDataSource>(),
      ),
    );
  }

  if (!getIt.isRegistered<SendMessageUseCase>()) {
    getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(
        chatRepository: getIt<ChatRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ),
    );
  }

  if (!getIt.isRegistered<GetMessagesUseCase>()) {
    getIt.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(
        chatRepository: getIt<ChatRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ),
    );
  }

  if (!getIt.isRegistered<DeleteMessageUseCase>()) {
    getIt.registerLazySingleton<DeleteMessageUseCase>(
      () => DeleteMessageUseCase(
        chatRepository: getIt<ChatRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ),
    );
  }

  if (!getIt.isRegistered<ChatBloc>()) {
    getIt.registerFactory<ChatBloc>(
      () => ChatBloc(
          sendMessageUseCase: getIt<SendMessageUseCase>(),
          // getMessageUseCase: getIt<GetMessagesUseCase>(), // Corrected here
          deletemessageUseCase: getIt<DeleteMessageUseCase>(),
          getMessagesUseCase: getIt<GetMessagesUseCase>()
          // tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          ),
    );
  }
}

Future<void> _initAuthDependencies() async {
  if (!getIt.isRegistered<TokenSharedPrefs>()) {
    getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()),
    );
  }

  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(
          getIt<AuthRemoteRepository>(), getIt<TokenSharedPrefs>()),
    );
  }

  if (!getIt.isRegistered<LogoutUseCase>()) {
    getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(getIt<TokenSharedPrefs>()),
    );
  }

  if (!getIt.isRegistered<GetAllUsersUseCase>()) {
    getIt.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(getIt<AuthRemoteRepository>()),
    );
  }

  if (!getIt.isRegistered<AuthBloc>()) {
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: getIt<LoginUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        tokenPrefs: getIt<TokenSharedPrefs>(),
        getAllUsersUseCase: getIt<GetAllUsersUseCase>(), // ✅ Corrected
      ),
    );
  }
}
