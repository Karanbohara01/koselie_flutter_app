import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/update_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late UpdateUserUseCase usecase;
  late MockRegisterRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockRegisterRepository();
    usecase = UpdateUserUseCase(mockAuthRepository);
  });

  const tAuthEntity = AuthEntity(
      username: 'testuser',
      email: 'test@example.com',
      password: 'testpassword@123'
      // ... other properties
      );

  test(
    'Should call the repository with the correct AuthEntity and return Right(void) on success',
    () async {
      // Arrange
      when(() => mockAuthRepository.updateUser(tAuthEntity))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(tAuthEntity);

      // Assert
      expect(result, const Right(null)); // Expect Right(void)

      // Verify that the repository method was called with the correct data
      verify(() => mockAuthRepository.updateUser(tAuthEntity)).called(1);

      // Ensure no other methods were called on the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return a Left(Failure) when the repository call fails',
    () async {
      // Arrange
      var tFailure = ServerFailure(message: 'Failed to update user.');
      when(() => mockAuthRepository.updateUser(tAuthEntity))
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase(tAuthEntity);

      // Assert
      expect(result, Left(tFailure));

      // Verify that the repository method was called with the correct data
      verify(() => mockAuthRepository.updateUser(tAuthEntity)).called(1);

      // Ensure no other methods were called on the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
