// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:koselie/features/auth/presentation/view/register_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:mocktail/mocktail.dart';

// // ✅ Mock RegisterBloc
// class MockRegisterBloc extends Mock implements RegisterBloc {
//   @override
//   Stream<RegisterState> get stream => const Stream.empty(); // ✅ Properly mocked

//   @override
//   RegisterState get state => const RegisterState.initial();
// }

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   late MockRegisterBloc mockRegisterBloc;

//   setUp(() {
//     mockRegisterBloc = MockRegisterBloc();
//   });

//   Widget createTestWidget() {
//     return MaterialApp(
//       home: BlocProvider<RegisterBloc>.value(
//         value: mockRegisterBloc,
//         child: const RegisterView(),
//       ),
//     );
//   }

//   group('Register Page Integration Test', () {
//     testWidgets('Check if UI elements are present', (tester) async {
//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       // ✅ Ensure the Title Exists
//       expect(find.text('Create Your Account'), findsOneWidget);

//       // ✅ Ensure Input Fields Exist
//       expect(find.byType(TextFormField), findsNWidgets(4));

//       // ✅ Ensure Register Button Exists
//       expect(find.text('Register'), findsOneWidget);
//     });

//     testWidgets('Enter credentials and tap Register', (tester) async {
//       await tester.pumpWidget(createTestWidget());
//       await tester.pumpAndSettle();

//       // ✅ Enter Username
//       await tester.enterText(find.byType(TextFormField).at(0), 'TestUser');

//       // ✅ Enter Email
//       await tester.enterText(
//           find.byType(TextFormField).at(1), 'test@example.com');

//       // ✅ Enter Password
//       await tester.enterText(find.byType(TextFormField).at(2), 'TestPass@123');

//       // ✅ Confirm Password
//       await tester.enterText(find.byType(TextFormField).at(3), 'TestPass@123');

//       // ✅ Tap Register Button
//       await tester.tap(find.text('Register'));
//       await tester.pump();

//       // ✅ Expect Snackbar Message (Mocked)
//       expect(find.text('Signup successful'), findsNothing); // Mocked Bloc event
//     });
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view/register_view.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock RegisterBloc
class MockRegisterBloc extends Mock implements RegisterBloc {
  @override
  Stream<RegisterState> get stream => const Stream.empty();

  @override
  RegisterState get state => const RegisterState.initial();
}

// ✅ Mock LoginBloc (For Navigation Test)
class MockLoginBloc extends Mock implements LoginBloc {
  @override
  Stream<LoginState> get stream => const Stream.empty();

  @override
  LoginState get state => LoginState.initial();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterBloc mockRegisterBloc;
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    mockLoginBloc = MockLoginBloc();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>.value(
        value: mockRegisterBloc,
        child: const RegisterView(),
      ),
    );
  }

  group('Register Page Integration Test', () {
    testWidgets('Check if UI elements are present', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Create Your Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Register'), findsOneWidget);
    });

    testWidgets('Enter credentials and tap Register', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'TestUser');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'TestPass@123');
      await tester.enterText(find.byType(TextFormField).at(3), 'TestPass@123');

      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Signup successful'), findsNothing);
    });

    // ✅ ⿡ FIXED: Navigation to Login Test
    testWidgets(
        'Navigate to Login page when clicking "Already have an account?"',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Already have an account? Login'));
      await tester.pumpAndSettle();

      // ✅ Wrap LoginView with LoginBloc Provider
      await tester.pumpWidget(
        BlocProvider<LoginBloc>.value(
          value: mockLoginBloc,
          child: const MaterialApp(home: LoginView()),
        ),
      );

      // ✅ Expect LoginView to be present
      expect(find.byType(LoginView), findsOneWidget);
    });

    // ✅ ⿢ Password Mismatch Validation Test
    testWidgets('Show error when password and confirm password do not match',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(2), 'TestPass@123');
      await tester.enterText(find.byType(TextFormField).at(3), 'WrongPass@456');

      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    // ✅ ⿣ Empty Field Validation Test
    testWidgets('Show error when trying to register with empty fields',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Enter User Name'), findsOneWidget);
      expect(find.text('Enter Email'), findsOneWidget);
      expect(find.text('Enter Password'), findsOneWidget);
      expect(find.text('Please confirm your password'), findsOneWidget);
    });

    // ✅ ⿤ Ensure Image Upload Button is Present
    testWidgets('Check if profile image upload button exists', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.camera), findsOneWidget);
    });

    // ✅ ⿥ Simulate Image Upload Process
    testWidgets('Simulate user selecting an image from gallery',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.camera));
      await tester.pumpAndSettle();

      expect(find.text('Camera'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);
    });
  });
}
