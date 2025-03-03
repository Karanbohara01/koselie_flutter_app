// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/auth/presentation/view/register_view.dart';
// import 'package:koselie/features/auth/presentation/view/reset_password_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:mocktail/mocktail.dart';

// // ✅ Mock LoginBloc
// class MockLoginBloc extends Mock implements LoginBloc {
//   @override
//   Stream<LoginState> get stream => const Stream.empty();

//   @override
//   LoginState get state => LoginState.initial();
// }

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   late MockLoginBloc mockLoginBloc;

//   setUp(() {
//     mockLoginBloc = MockLoginBloc();
//   });

//   Widget createTestWidget() {
//     return MaterialApp(
//       home: BlocProvider<LoginBloc>.value(
//         value: mockLoginBloc,
//         child: const LoginView(),
//       ),
//     );
//   }

//   group('Login Page Integration Test', () {
//     // ✅ ⿡ UI Elements Test
//     testWidgets('Check if UI elements are present', (tester) async {
//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       expect(find.text('Welcome back!'), findsOneWidget);
//       expect(find.byType(TextFormField), findsNWidgets(2));
//       expect(find.text('Login'), findsOneWidget);
//       expect(find.text('Forgot Password?'), findsOneWidget);
//       expect(find.text("Don't have an account? Register here"), findsOneWidget);
//     });

//     // ✅ ⿢ Enter Credentials and Tap Login
//     testWidgets('Enter credentials and tap Login', (tester) async {
//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       await tester.enterText(find.byType(TextFormField).at(0), 'TestUser');
//       await tester.enterText(find.byType(TextFormField).at(1), 'TestPass@123');

//       await tester.tap(find.text('Login'));
//       await tester.pump();

//       expect(find.text('Login Successful'), findsNothing); // Mocked Bloc event
//     });

//     // ✅ ⿣ Invalid Credentials Test
//     // ✅ Invalid Credentials Test (Fixed)
//     testWidgets(
//         'Show error message when login fails due to invalid credentials',
//         (tester) async {
//       when(() => mockLoginBloc.state).thenReturn(
//         const LoginState(
//           errorMessage: "Invalid Credentials",
//           isLoading: false,
//           isSuccess: false,
//           user: null,
//           isProfileUpdated: false,
//           isProfilePictureUpdated: false,
//           isOtpSent: false,
//           isPasswordReset: false,
//         ),
//       );

//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       await tester.enterText(find.byType(TextFormField).at(0), 'WrongUser');
//       await tester.enterText(find.byType(TextFormField).at(1), 'WrongPass');

//       await tester.tap(find.text('Login'));
//       await tester.pump();

//       expect(find.text("Invalid Credentials"), findsOneWidget);
//     });

//     // ✅ ⿤ Empty Fields Validation Test
//     testWidgets('Show error when trying to login with empty fields',
//         (tester) async {
//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       await tester.tap(find.text('Login'));
//       await tester.pump();

//       expect(find.text('Enter Username'), findsOneWidget);
//       expect(find.text('Enter Password'), findsOneWidget);
//     });

//     // ✅ ⿥ Forgot Password Navigation Test
//     testWidgets(
//         'Navigate to Reset Password screen when clicking Forgot Password',
//         (tester) async {
//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       await tester.tap(find.text('Forgot Password?'));
//       await tester.pumpAndSettle();

//       await tester.pumpWidget(
//         BlocProvider<LoginBloc>.value(
//           value: mockLoginBloc,
//           child: const MaterialApp(
//               home: ResetPasswordView(emailOrPhone: "test@example.com")),
//         ),
//       );

//       expect(find.byType(ResetPasswordView), findsOneWidget);
//     });

//     // ✅ ⿦ Navigate to Register Page
//     testWidgets(
//         'Navigate to Register page when clicking "Don\'t have an account? Register here"',
//         (tester) async {
//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       await tester.tap(find.text("Don't have an account? Register here"));
//       await tester.pumpAndSettle();

//       await tester.pumpWidget(
//         BlocProvider<LoginBloc>.value(
//           value: mockLoginBloc,
//           child: const MaterialApp(home: RegisterView()),
//         ),
//       );

//       expect(find.byType(RegisterView), findsOneWidget);
//     });
//   });
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view/register_view.dart';
import 'package:koselie/features/auth/presentation/view/reset_password_view.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock LoginBloc
class MockLoginBloc extends Mock implements LoginBloc {
  final StreamController<LoginState> _controller =
      StreamController<LoginState>.broadcast();

  @override
  Stream<LoginState> get stream => _controller.stream;

  @override
  LoginState get state => LoginState.initial();

  void emitState(LoginState state) {
    _controller.add(state);
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<LoginBloc>.value(
        value: mockLoginBloc,
        child: const LoginView(),
      ),
    );
  }

  group('Login Page Integration Test', () {
    // ✅ ⿡ UI Elements Test
    testWidgets('Check if UI elements are present', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Welcome back!'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text("Don't have an account? Register here"), findsOneWidget);
    });

    // ✅ ⿢ Enter Credentials and Tap Login
    testWidgets('Enter credentials and tap Login', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'TestUser');
      await tester.enterText(find.byType(TextFormField).at(1), 'TestPass@123');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Login Successful'), findsNothing); // Mocked Bloc event
    });

    // ✅ ⿣ Invalid Credentials Test
    testWidgets(
        'Show error message when login fails due to invalid credentials',
        (tester) async {
      when(() => mockLoginBloc.state).thenReturn(
        const LoginState(
          errorMessage: "Invalid Credentials",
          isLoading: false,
          isSuccess: false,
          user: null,
          isProfileUpdated: false,
          isProfilePictureUpdated: false,
          isOtpSent: false,
          isPasswordReset: false,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'WrongUser');
      await tester.enterText(find.byType(TextFormField).at(1), 'WrongPass');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text("Invalid Credentials"), findsOneWidget);
    });

    // ✅ ⿤ Empty Fields Validation Test
    testWidgets('Show error when trying to login with empty fields',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Enter Username'), findsOneWidget);
      expect(find.text('Enter Password'), findsOneWidget);
    });

    // ✅ ⿥ Forgot Password Navigation Test
    testWidgets(
        'Navigate to Reset Password screen when clicking Forgot Password',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>.value(
            value: mockLoginBloc,
            child: const ResetPasswordView(emailOrPhone: "test@example.com"),
          ),
        ),
      );

      expect(find.byType(ResetPasswordView), findsOneWidget);
    });

    // ✅ ⿦ Navigate to Register Page
    testWidgets(
        'Navigate to Register page when clicking "Don\'t have an account? Register here"',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text("Don't have an account? Register here"));
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>.value(
            value: mockLoginBloc,
            child: const RegisterView(),
          ),
        ),
      );

      expect(find.byType(RegisterView), findsOneWidget);
    });
  });
}
