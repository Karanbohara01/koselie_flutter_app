import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/app/di/di.dart';
import 'package:koselie/core/theme/app_theme.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';
import 'package:koselie/features/home/presentation/view/home_view.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/splash/presentation/view/splash_view.dart';
import 'package:koselie/features/splash/presentation/view_model/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  /// ✅ **Navigates to a specific screen while clearing previous stack**
  void _navigateToScreen(BuildContext context, Widget screen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => screen),
        (route) => false, // ✅ Clears the navigation stack
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) {
            final splashCubit = getIt<SplashCubit>();
            splashCubit.init();
            return splashCubit;
          },
        ),
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) => getIt<CategoryBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<PostsBloc>(
          create: (_) => getIt<PostsBloc>(),
        ),
        BlocProvider<ChatBloc>(
          create: (_) => getIt<ChatBloc>(), // ✅ Removed `LoadTokenEvent`
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _navigateToScreen(
                context, const HomeView()); // ✅ Navigate to Home on login
          } else if (state is AuthUnauthenticated) {
            _navigateToScreen(
                context, LoginView()); // ✅ Navigate to Login on logout
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Koselie',
          theme: AppTheme.getApplicationTheme(isDarkMode: false),
          home: const SplashView(),
        ),
      ),
    );
  }
}
