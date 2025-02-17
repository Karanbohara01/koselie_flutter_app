// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/home/presentation/view/home_view.dart';
// import 'package:koselie/features/onboarding/presentation/view/onboarding_view.dart';

// class SplashCubit extends Cubit<void> {
//   final TokenSharedPrefs _tokenPrefs;

//   SplashCubit(this._tokenPrefs) : super(null);

//   Future<void> init(BuildContext context) async {
//     await Future.delayed(const Duration(seconds: 2));

//     final tokenResult = await _tokenPrefs.getToken();

//     tokenResult.fold(
//       (failure) {
//         // ❌ If error fetching token, go to Onboarding
//         _navigateTo(context, const OnboardingScreen());
//       },
//       (token) {
//         if (token != null && token.isNotEmpty) {
//           // ✅ If token exists, go to Home
//           _navigateTo(context, const HomeView());
//         } else {
//           // 🛑 No token found, go to Login
//           _navigateTo(context, LoginView());
//         }
//       },
//     );
//   }

//   void _navigateTo(BuildContext context, Widget destination) {
//     if (context.mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => destination),
//       );
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final TokenSharedPrefs _tokenPrefs;
  final SharedPreferences _prefs;

  SplashCubit(this._tokenPrefs, this._prefs) : super(SplashInitial());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasCompletedOnboarding =
        _prefs.getBool('hasCompletedOnboarding') ?? false;
    final tokenResult = await _tokenPrefs.getToken();

    tokenResult.fold(
      (failure) {
        emit(SplashNavigateToOnboarding());
      },
      (token) {
        if (token != null && token.isNotEmpty) {
          emit(SplashNavigateToHome()); // ✅ User is logged in
        } else {
          emit(hasCompletedOnboarding
              ? SplashNavigateToLogin()
              : SplashNavigateToOnboarding());
        }
      },
    );
  }
}
