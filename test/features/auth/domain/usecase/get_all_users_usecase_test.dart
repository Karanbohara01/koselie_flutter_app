import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';
import 'package:koselie/features/auth/domain/usecase/get_all_users_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock Dependencies
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late GetAllUsersUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetAllUsersUseCase(mockAuthRepository);
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

  const tAuthEntities = [
    AuthEntity(
      username: 'user1',
      email: 'user1@example.com',
      password: 'password1',
    ),
    AuthEntity(
      username: 'user2',
      email: 'user2@example.com',
      password: 'password2',
    ),
  ];

  test(
    'Should return a list of AuthEntities when repository call is successful',
    () async {
      // Arrange: Mock successful response
      when(() => mockAuthRepository.getAllUsers())
          .thenAnswer((_) async => const Right(tAuthEntities));

      // Act
      final result = await usecase();

      // Assert
      expect(result, const Right(tAuthEntities));

      // Verify that the repository method was called once
      verify(() => mockAuthRepository.getAllUsers()).called(1);

      // Ensure no other interactions
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return Left(Failure) when repository call fails',
    () async {
      // Arrange: Simulate repository failure
      var tFailure = ServerFailure('Failed to fetch users.');
      when(() => mockAuthRepository.getAllUsers())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(tFailure));

      // Verify that the repository method was called once
      verify(() => mockAuthRepository.getAllUsers()).called(1);

      // Ensure no other interactions
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
