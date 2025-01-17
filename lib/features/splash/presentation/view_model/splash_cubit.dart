// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';

// class SplashCubit extends Cubit<void> {
//   SplashCubit(this._loginBloc) : super(null);

//   final LoginBloc _loginBloc;

//   Future<void> init(BuildContext context) async {
//     await Future.delayed(const Duration(seconds: 2), () async {
//       // Open Login page or Onboarding Screen

//       if (context.mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BlocProvider.value(
//               value: _loginBloc,
//               child: LoginView(),
//             ),
//           ),
//         );
//       }
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/onboarding/presentation/view/onboarding_view.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._loginBloc) : super(null);

  final LoginBloc _loginBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Navigate to Onboarding Screen first
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      }
    });
  }
}
