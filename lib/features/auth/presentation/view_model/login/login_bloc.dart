import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/update_user_usecase.dart';
import 'package:koselie/features/auth/presentation/view/reset_password_view.dart';
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
  final UpdateUserUsecase _updateUserUseCase;
  final TokenSharedPrefs _tokenSharedPrefs;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateUserUsecase updateUserUseCase,
    required TokenSharedPrefs tokenSharedPrefs,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _updateUserUseCase = updateUserUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(_onNavigateRegisterScreen);
    on<NavigateHomeScreenEvent>(_onNavigateHomeScreen);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserInfoEvent>(_onGetUserInfo);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<UpdateProfilePictureEvent>(_onUpdateProfilePicture);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  /// 🔹 Handle Forgot Password Request
  Future<void> _onForgotPasswordRequested(
      ForgotPasswordRequested event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _forgotPasswordUseCase(
      ForgotPasswordParams(email: event.email, phone: event.phone),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
        showMySnackBar(
          context: event.context,
          message: "Failed to send OTP: ${failure.message}",
          color: Colors.red,
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "OTP sent successfully. Check your email/phone.",
          color: Colors.green,
        );

        // Navigate to Reset Password View
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordView(
              emailOrPhone: event.email ?? event.phone!,
            ),
          ),
        );
      },
    );
  }

  /// 🔹 Handle Reset Password Request
  Future<void> _onResetPasswordRequested(
      ResetPasswordRequested event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _resetPasswordUseCase(
      ResetPasswordParams(
        email: event.emailOrPhone.contains("@") ? event.emailOrPhone : null,
        phone: event.emailOrPhone.contains("@") ? null : event.emailOrPhone,
        otp: event.otp,
        newPassword: event.newPassword,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
        showMySnackBar(
          context: event.context,
          message: "Failed to reset password: ${failure.message}",
          color: Colors.red,
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Password reset successfully. Please log in.",
          color: Colors.green,
        );

        // Redirect to login screen
        Navigator.pop(event.context);
      },
    );
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
        print(
            "User fetched successfully: ${user.username}, ${user.email},${user.bio}");
        emit(state.copyWith(isLoading: false, user: user));
      },
    );
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    if (state.user == null) {
      emit(state.copyWith(
        isLoading: false,
      ));
      if (event.context.mounted) {
        showMySnackBar(
          context: event.context,
          message: "No user data available!",
          color: Colors.red,
        );
      }
      return;
    }

    // ✅ Retrieve token before making API call
    final tokenResult = await _tokenSharedPrefs.getToken();
    final token = tokenResult.fold(
      (failure) => null,
      (token) => token,
    );

    if (token == null) {
      emit(state.copyWith(
        isLoading: false,
      ));
      if (event.context.mounted) {
        showMySnackBar(
          context: event.context,
          message: "Authentication failed. Please log in again.",
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

    final result =
        await _updateUserUseCase.call(UpdateUserParams(entity: updatedUser));

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
        ));
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
