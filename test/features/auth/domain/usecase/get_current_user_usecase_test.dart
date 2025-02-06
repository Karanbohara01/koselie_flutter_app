import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

// Create a mock for the IAuthRepository

void main() {
  late GetCurrentUserUseCase usecase;
  late MockRegisterRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockRegisterRepository();
    usecase = GetCurrentUserUseCase(mockAuthRepository);
  });

  const tAuthEntity = AuthEntity(
      username: 'testuser', email: 'test@example.com', password: "test@123");

  test(
    'Should return an AuthEntity when getCurrentUser is successful',
    () async {
      // Arrange: Setup the mock to return a Right(tAuthEntity)
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const Right(tAuthEntity));

      // Act: Call the use case
      final result = await usecase();

      // Assert: Check if the result is Right(tAuthEntity)
      expect(result, const Right(tAuthEntity));

      // Verify that the repository method was called
      verify(() => mockAuthRepository.getCurrentUser()).called(1);

      // Ensure no other interactions occurred with the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return a Failure when getCurrentUser fails',
    () async {
      // Arrange: Setup the mock to return a Left(ServerFailure)
      var tFailure = ServerFailure(message: 'Failed to get current user.');
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => Left(tFailure));

      // Act: Call the use case
      final result = await usecase();

      // Assert: Check if the result is Left(ServerFailure)
      expect(result, Left(tFailure));

      // Verify that the repository method was called
      verify(() => mockAuthRepository.getCurrentUser()).called(1);

      // Ensure no other interactions occurred with the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
