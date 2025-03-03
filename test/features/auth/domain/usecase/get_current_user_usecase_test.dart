import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';
import 'package:koselie/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock Dependencies
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late GetCurrentUserUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCurrentUserUseCase(mockAuthRepository);
  });

  setUpAll(() {
    registerFallbackValue(
      const AuthEntity(
        username: 'testuser',
        email: 'test@example.com',
        password: 'testpassword@123',
      ),
    );
  });

  const tAuthEntity = AuthEntity(
    username: 'testuser',
    email: 'test@example.com',
    password: 'testpassword@123',
  );

  test(
    'Should return the AuthEntity when repository call is successful',
    () async {
      // Arrange: Mock successful response
      when(() => mockAuthRepository.getMe())
          .thenAnswer((_) async => const Right(tAuthEntity));

      // Act
      final result = await usecase();

      // Assert
      expect(result, const Right(tAuthEntity));

      // Verify that the repository method was called once
      verify(() => mockAuthRepository.getMe()).called(1);

      // Ensure no other interactions
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return Left(Failure) when repository call fails',
    () async {
      // Arrange: Simulate repository failure
      var tFailure = ServerFailure('Failed to fetch user.');
      when(() => mockAuthRepository.getMe())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(tFailure));

      // Verify that the repository method was called once
      verify(() => mockAuthRepository.getMe()).called(1);

      // Ensure no other interactions
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
