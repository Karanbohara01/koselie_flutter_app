import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/home/presentation/view/home_view.dart';
import 'package:koselie/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:koselie/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:koselie/features/splash/presentation/view_model/splash_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().init(); // ✅ Calls init()
  }

  void _navigate(BuildContext context, Widget destination) {
    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToOnboarding) {
          _navigate(context, const OnboardingScreen());
        } else if (state is SplashNavigateToLogin) {
          _navigate(context, LoginView());
        } else if (state is SplashNavigateToHome) {
          _navigate(context, const HomeView());
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A0DAD), // Dark Purple
                Color(0xFF9C27B0), // Light Purple
                Color(0xFFEC407A), // Pinkish Gradient
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ✅ Logo
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/logo/logo.png'),
                    ),
                    const SizedBox(height: 10),

                    // ✅ App Name
                    const Text(
                      'Koselie',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ✅ Loading Indicator
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 15),

                    // ✅ App Version
                    const Text(
                      'version: 1.0.0',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              // ✅ Footer
              const Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Powered by: Koselie',
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
