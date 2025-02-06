import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockRegisterRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase useCase;

  setUp(() {
    repository = MockRegisterRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = LoginUseCase(repository, tokenSharedPrefs);
  });

  test(
      'Should call the [AuthRepo.login] with the correct username and password(karan,karan@123)',
      () async {
    const expectedUsername = 'karan';
    const expectedPassword = 'karan@123';

    when(() => repository.loginUser(expectedUsername, expectedPassword))
        .thenAnswer((_) async {
      return const Right('token');
    });

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await useCase(const LoginParams(
        username: expectedUsername, password: expectedPassword));
    expect(result, const Right('token'));

    verify(() => repository.loginUser(expectedUsername, expectedPassword))
        .called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
