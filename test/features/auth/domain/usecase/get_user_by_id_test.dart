import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/get_user_by_id.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late GetUserByIdUseCase usecase;
  late MockRegisterRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockRegisterRepository();
    usecase = GetUserByIdUseCase(mockAuthRepository);
  });

  const tUserId = 'testUserId';
  const tAuthEntity = AuthEntity(
      username: 'testuser',
      email: 'test@example.com',
      password: 'testpassword');

  test(
    'Should return an AuthEntity when getUserById is successful',
    () async {
      // Arrange
      when(() => mockAuthRepository.getUserById(tUserId))
          .thenAnswer((_) async => const Right(tAuthEntity));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, const Right(tAuthEntity));

      // Verify that the repository method was called with the correct data
      verify(() => mockAuthRepository.getUserById(tUserId)).called(1);

      // Ensure no other methods were called on the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return a Failure when getUserById fails',
    () async {
      // Arrange
      final tFailure = ServerFailure(message: 'Failed to get user by ID.');
      when(() => mockAuthRepository.getUserById(tUserId))
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, Left(tFailure));

      // Verify that the repository method was called with the correct data
      verify(() => mockAuthRepository.getUserById(tUserId)).called(1);

      // Ensure no other methods were called on the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
