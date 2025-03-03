import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/get_all_users_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/logout_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock Classes
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockGetAllUsersUseCase extends Mock implements GetAllUsersUseCase {}

// ✅ Fake Params for Mocktail
class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late AuthBloc authBloc;
  late MockTokenSharedPrefs mockTokenPrefs;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockGetAllUsersUseCase mockGetAllUsersUseCase;

  // ✅ Sample Data
  const validToken = "valid_token_123";
  const invalidToken = "";
  final usersList = [
    const AuthEntity(
        userId: '1', username: 'john_doe', email: 'john@example.com'),
    const AuthEntity(
        userId: '2', username: 'jane_doe', email: 'jane@example.com'),
  ];

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
  });

  setUp(() {
    mockTokenPrefs = MockTokenSharedPrefs();
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockGetAllUsersUseCase = MockGetAllUsersUseCase();

    authBloc = AuthBloc(
      tokenPrefs: mockTokenPrefs,
      loginUseCase: mockLoginUseCase,
      logoutUseCase: mockLogoutUseCase,
      getAllUsersUseCase: mockGetAllUsersUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  // ✅ 1️⃣ Initial State Test
  test('Initial state is AuthInitial()', () {
    expect(authBloc.state, AuthInitial());
  });

  // ✅ 2️⃣ Auth Check - User is Authenticated
  blocTest<AuthBloc, AuthState>(
    'emits [AuthAuthenticated] when a valid token is found',
    build: () {
      when(() => mockTokenPrefs.getToken())
          .thenAnswer((_) async => const Right(validToken));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthCheckRequested()),
    expect: () => [AuthAuthenticated(token: validToken)],
  );

  // ✅ 3️⃣ Auth Check - User is Unauthenticated
  blocTest<AuthBloc, AuthState>(
    'emits [AuthUnauthenticated] when no token is found',
    build: () {
      when(() => mockTokenPrefs.getToken())
          .thenAnswer((_) async => const Right(invalidToken));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthCheckRequested()),
    expect: () => [AuthUnauthenticated()],
  );

  // ✅ 6️⃣ Logout - Success
  blocTest<AuthBloc, AuthState>(
    'emits [AuthUnauthenticated] when logout is successful',
    build: () {
      when(() => mockLogoutUseCase.call())
          .thenAnswer((_) async => const Right(null));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthLogoutRequested()),
    expect: () => [AuthUnauthenticated()],
  );

  // ✅ 7️⃣ Get All Users - Success
  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoadingUsers, AuthUsersLoaded] when users are fetched successfully',
    build: () {
      when(() => mockGetAllUsersUseCase.call())
          .thenAnswer((_) async => Right(usersList));
      return authBloc;
    },
    act: (bloc) => bloc.add(GetAllUsersRequested()),
    expect: () => [
      AuthLoadingUsers(),
      AuthUsersLoaded(users: usersList),
    ],
  );
}
