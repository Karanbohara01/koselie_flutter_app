import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late MockRegisterRepository repository;
  late RegisterUseCase usecase;

  setUp(() {
    repository = MockRegisterRepository();
    usecase = RegisterUseCase(repository);

    // Register fallback values for required types
    registerFallbackValue(const AuthEntity.empty());
    registerFallbackValue(const RegisterUserParams.empty());
  });

  const params = RegisterUserParams.empty();

  test("Should call the [RegisterRepo.registerUser]", () async {
    // Arrange
    when(() => repository.registerUser(any())).thenAnswer(
      (_) async => const Right(null),
    );

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(null));

    // Verify
    verify(() => repository.registerUser(any<AuthEntity>())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
