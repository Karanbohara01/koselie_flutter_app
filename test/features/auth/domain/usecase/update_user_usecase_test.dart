import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/usecase/delete_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late DeleteUserUseCase usecase;
  late MockRegisterRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockRegisterRepository();
    usecase = DeleteUserUseCase(mockAuthRepository);
  });

  const tUserId = 'testUserId';

  test(
    'Should call the repository with the correct userId and return Right(void) on success',
    () async {
      // Arrange
      when(() => mockAuthRepository.deleteUser(tUserId))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, const Right(null));

      // Verify that the repository method was called with the correct data
      verify(() => mockAuthRepository.deleteUser(tUserId)).called(1);

      // Ensure no other methods were called on the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return a Left(Failure) when the repository call fails',
    () async {
      // Arrange
      var tFailure = ServerFailure(message: 'Failed to delete user.');
      when(() => mockAuthRepository.deleteUser(tUserId))
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, Left(tFailure));

      // Verify that the repository method was called with the correct data
      verify(() => mockAuthRepository.deleteUser(tUserId)).called(1);

      // Ensure no other methods were called on the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
