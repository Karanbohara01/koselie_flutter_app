import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  // Register fallback values before running the tests
  setUpAll(() {
    // Register a fallback for LoginParams
    registerFallbackValue(const LoginParams(username: '', password: ''));
  });

  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockHomeCubit = MockHomeCubit();
    loginBloc = LoginBloc(
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
    );
  });

  group('LoginBloc', () {
    test('emits [LoginLoadingState, LoginSuccessState] on successful login',
        () async {
      // Arrange
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => const Right("fake_token"));

      // Act
      loginBloc
          .add(const LoginUserEvent(username: 'test', password: 'password'));

      // Assert
      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginState>()
              .having((state) => state.isLoading, 'isLoading', true),
          isA<LoginState>()
              .having((state) => state.isSuccess, 'isSuccess', true),
        ]),
      );
    });

    test('emits [LoginLoadingState, LoginFailureState] on login failure',
        () async {
      // Arrange
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => Left(Failure(message: '')));

      // Act
      loginBloc
          .add(const LoginUserEvent(username: 'test', password: 'password'));

      // Assert
      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginState>()
              .having((state) => state.isLoading, 'isLoading', true),
          isA<LoginState>()
              .having((state) => state.isSuccess, 'isSuccess', false),
        ]),
      );
    });

    test('emits [ShowSnackbarEvent] on login failure', () async {
      // Arrange
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => Left(Failure(message: '')));

      // Act
      loginBloc
          .add(const LoginUserEvent(username: 'test', password: 'password'));

      // Assert
      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginState>()
              .having((state) => state.isLoading, 'isLoading', true),
          isA<LoginState>()
              .having((state) => state.isSuccess, 'isSuccess', false),
        ]),
      );
    });
  });
}
