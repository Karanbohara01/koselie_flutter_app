// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:koselie/features/home/presentation/view/home_view.dart';
// import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final RegisterBloc _registerBloc;
//   final HomeCubit _homeCubit;
//   final LoginUseCase _loginUseCase;
//   final TokenSharedPrefs _tokenSharedPrefs; // ✅ Added Token Storage

//   LoginBloc({
//     required RegisterBloc registerBloc,
//     required HomeCubit homeCubit,
//     required LoginUseCase loginUseCase,
//     required TokenSharedPrefs tokenSharedPrefs, // ✅ Injected Token Storage
//   })  : _registerBloc = registerBloc,
//         _homeCubit = homeCubit,
//         _loginUseCase = loginUseCase,
//         _tokenSharedPrefs = tokenSharedPrefs, // ✅ Assigning Token Storage
//         super(LoginState.initial()) {
//     on<NavigateRegisterScreenEvent>(_onNavigateRegisterScreen);
//     on<NavigateHomeScreenEvent>(_onNavigateHomeScreen);
//     on<LoginUserEvent>(_onLoginUser);
//   }

//   /// 🔹 Navigate to Register Screen
//   void _onNavigateRegisterScreen(
//       NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
//     Navigator.push(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => MultiBlocProvider(
//           providers: [BlocProvider.value(value: _registerBloc)],
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   /// 🔹 Navigate to Home Screen
//   void _onNavigateHomeScreen(
//       NavigateHomeScreenEvent event, Emitter<LoginState> emit) {
//     Navigator.pushReplacement(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _homeCubit,
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   //  Handle login user info

//   /// 🔹 Handle Login & Token Storage
//   Future<void> _onLoginUser(
//       LoginUserEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _loginUseCase(
//       LoginParams(username: event.username, password: event.password),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, isSuccess: false));
//         showMySnackBar(
//           context: event.context,
//           message: "Invalid Credentials",
//           color: Colors.red,
//         );
//       },
//       (token) async {
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//         showMySnackBar(
//           context: event.context,
//           message: "Login Successful",
//           color: Colors.green,
//         );

//         // ✅ Save Token to SharedPreferences for Persistence
//         await _tokenSharedPrefs.saveToken(token);

//         // ✅ Redirect to Home Screen
//         add(NavigateHomeScreenEvent(
//           context: event.context,
//           destination: const HomeView(),
//         ));
//       },
//     );
//   }
// }

//  for profile

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:koselie/features/auth/domain/usecase/get_current_user_usecase.dart';
// import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:koselie/features/home/presentation/view/home_view.dart';
// import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final RegisterBloc _registerBloc;
//   final HomeCubit _homeCubit;
//   final LoginUseCase _loginUseCase;
//   final GetCurrentUserUseCase
//       _getCurrentUserUseCase; // ✅ Injected User Info UseCase
//   final TokenSharedPrefs _tokenSharedPrefs;

//   LoginBloc({
//     required RegisterBloc registerBloc,
//     required HomeCubit homeCubit,
//     required LoginUseCase loginUseCase,
//     required GetCurrentUserUseCase getCurrentUserUseCase, // ✅ Injected
//     required TokenSharedPrefs tokenSharedPrefs,
//   })  : _registerBloc = registerBloc,
//         _homeCubit = homeCubit,
//         _loginUseCase = loginUseCase,
//         _getCurrentUserUseCase = getCurrentUserUseCase, // ✅ Assigning
//         _tokenSharedPrefs = tokenSharedPrefs,
//         super(LoginState.initial()) {
//     on<NavigateRegisterScreenEvent>(_onNavigateRegisterScreen);
//     on<NavigateHomeScreenEvent>(_onNavigateHomeScreen);
//     on<LoginUserEvent>(_onLoginUser);
//     on<GetUserInfoEvent>(_onGetUserInfo); // ✅ Handle fetching user info
//   }

//   /// 🔹 Navigate to Register Screen
//   void _onNavigateRegisterScreen(
//       NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
//     Navigator.push(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => MultiBlocProvider(
//           providers: [BlocProvider.value(value: _registerBloc)],
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   /// 🔹 Navigate to Home Screen
//   void _onNavigateHomeScreen(
//       NavigateHomeScreenEvent event, Emitter<LoginState> emit) {
//     Navigator.pushReplacement(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _homeCubit,
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   /// 🔹 Handle Login & Fetch User Info
//   Future<void> _onLoginUser(
//       LoginUserEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _loginUseCase(
//       LoginParams(username: event.username, password: event.password),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, isSuccess: false));
//         showMySnackBar(
//           context: event.context,
//           message: "Invalid Credentials",
//           color: Colors.red,
//         );
//       },
//       (token) async {
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//         showMySnackBar(
//           context: event.context,
//           message: "Login Successful",
//           color: Colors.green,
//         );

//         // ✅ Save Token to SharedPreferences for Persistence
//         await _tokenSharedPrefs.saveToken(token);

//         // ✅ Fetch Logged-in User Info
//         add(GetUserInfoEvent(context: event.context)); // ✅ Pass context here

//         // ✅ Redirect to Home Screen
//         add(NavigateHomeScreenEvent(
//           context: event.context,
//           destination: const HomeView(),
//         ));
//       },
//     );
//   }

//   /// 🔹 Fetch Logged-in User Info
//   Future<void> _onGetUserInfo(
//       GetUserInfoEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true)); // 🔹 Set loading state first

//     final result = await _getCurrentUserUseCase(); // 🔹 Call the use case

//     result.fold(
//       (failure) {
//         print("Error fetching user info: ${failure.message}");
//         emit(state.copyWith(isLoading: false)); // 🔴 Error state
//       },
//       (user) {
//         print(
//             "User fetched successfully: ${user.username}, ${user.email}"); // 🔹 Debugging
//         emit(state.copyWith(
//             isLoading: false, user: user)); // ✅ Ensure state contains user info
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/update_user_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:koselie/features/home/presentation/view/home_view.dart';
import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final TokenSharedPrefs _tokenSharedPrefs;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateUserUseCase updateUserUseCase,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _updateUserUseCase = updateUserUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(_onNavigateRegisterScreen);
    on<NavigateHomeScreenEvent>(_onNavigateHomeScreen);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserInfoEvent>(_onGetUserInfo);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<UpdateProfilePictureEvent>(_onUpdateProfilePicture);
  }

  /// 🔹 Navigate to Register Screen
  void _onNavigateRegisterScreen(
      NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [BlocProvider.value(value: _registerBloc)],
          child: event.destination,
        ),
      ),
    );
  }

  /// 🔹 Navigate to Home Screen
  void _onNavigateHomeScreen(
      NavigateHomeScreenEvent event, Emitter<LoginState> emit) {
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _homeCubit,
          child: event.destination,
        ),
      ),
    );
  }

  /// 🔹 Handle Login & Fetch User Info
  Future<void> _onLoginUser(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _loginUseCase(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: "Invalid Credentials",
          color: Colors.red,
        );
      },
      (token) async {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Login Successful",
          color: Colors.green,
        );

        // ✅ Save Token to SharedPreferences
        await _tokenSharedPrefs.saveToken(token);

        // ✅ Fetch User Info
        add(GetUserInfoEvent(context: event.context));

        // ✅ Redirect to Home Screen
        add(NavigateHomeScreenEvent(
          context: event.context,
          destination: const HomeView(),
        ));
      },
    );
  }

  /// 🔹 Fetch Logged-in User Info
  Future<void> _onGetUserInfo(
      GetUserInfoEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getCurrentUserUseCase();

    result.fold(
      (failure) {
        print("Error fetching user info: ${failure.message}");
        emit(state.copyWith(isLoading: false));
      },
      (user) {
        print("User fetched successfully: ${user.username}, ${user.email}");
        emit(state.copyWith(isLoading: false, user: user));
      },
    );
  }

  /// 🔹 Fix: Prevent ScaffoldMessenger Error
  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    if (state.user == null) {
      emit(state.copyWith(isLoading: false));
      if (event.context.mounted) {
        showMySnackBar(
          context: event.context,
          message: "No user data available!",
          color: Colors.red,
        );
      }
      return;
    }

    final updatedUser = state.user!.copyWith(
      username: event.username,
      bio: event.bio,
      role: event.role,
    );

    final result = await _updateUserUseCase(updatedUser);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: "Profile update failed: ${failure.message}",
            color: Colors.red,
          );
        }
      },
      (_) {
        emit(state.copyWith(isLoading: false, user: updatedUser));
        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: "Profile updated successfully!",
            color: Colors.green,
          );
        }
      },
    );
  }

  /// 🔹 Handle Profile Picture Update
  Future<void> _onUpdateProfilePicture(
      UpdateProfilePictureEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    // Simulating API call for profile picture update
    await Future.delayed(const Duration(seconds: 2));

    const newProfilePictureUrl =
        "https://your-cloudinary-url.com/new-image.jpg";

    final updatedUser =
        state.user?.copyWith(profilePicture: newProfilePictureUrl);

    emit(state.copyWith(
      isLoading: false,
      user: updatedUser,
    ));

    showMySnackBar(
      context: event.context,
      message: "Profile picture updated successfully!",
      color: Colors.green,
    );
  }
}

// // for testing only
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
// import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final HomeCubit _homeCubit;
//   final LoginUseCase _loginUseCase;

//   LoginBloc({
//     required HomeCubit homeCubit,
//     required LoginUseCase loginUseCase,
//   })  : _homeCubit = homeCubit,
//         _loginUseCase = loginUseCase,
//         super(LoginState.initial()) {
//     on<LoginUserEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true));

//       final result = await _loginUseCase(
//         LoginParams(username: event.username, password: event.password),
//       );

//       result.fold(
//         (failure) {
//           emit(state.copyWith(isLoading: false, isSuccess: false));
//           // Emitting error event for snackbar
//           add(const ShowSnackbarEvent(message: "Invalid Credentials"));
//         },
//         (token) {
//           emit(state.copyWith(isLoading: false, isSuccess: true));
//           // Emitting success event for snackbar
//           add(const ShowSnackbarEvent(message: "Login Successful"));
//           // Emitting navigation event to Home screen
//           add(NavigateToHomeEvent());
//         },
//       );
//     });

//     on<ShowSnackbarEvent>((event, emit) {
//       // This event will be handled by the UI layer to show snackbar
//     });

//     on<NavigateToHomeEvent>((event, emit) {
//       // This event will be handled by the UI layer to navigate to the home screen
//     });
//   }
// }
