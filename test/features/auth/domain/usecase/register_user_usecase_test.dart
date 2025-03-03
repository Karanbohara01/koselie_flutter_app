import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';
import 'package:koselie/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock Dependencies
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RegisterUseCase(mockAuthRepository);
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

  const tRegisterParams = RegisterUserParams(
    username: 'testuser',
    email: 'test@example.com',
    password: 'testpassword@123',
    image: 'profile.jpg',
  );

  const tAuthEntity = AuthEntity(
    username: 'testuser',
    email: 'test@example.com',
    password: 'testpassword@123',
    image: 'profile.jpg',
  );

  test(
    'Should call the repository with correct parameters and return Right(void) on success',
    () async {
      // Arrange: Mock repository success response
      when(() => mockAuthRepository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(tRegisterParams);

      // Assert
      expect(result, const Right(null)); // ✅ Right(void) on success

      // Verify that repository method was called with correct data
      verify(() => mockAuthRepository.registerUser(tAuthEntity)).called(1);

      // Ensure no other interactions
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return Left(Failure) when repository call fails',
    () async {
      // Arrange: Simulate repository failure
      var tFailure = ServerFailure('Failed to register user.');
      when(() => mockAuthRepository.registerUser(any()))
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase(tRegisterParams);

      // Assert
      expect(result, Left(tFailure));

      // Verify that repository method was called with correct data
      verify(() => mockAuthRepository.registerUser(tAuthEntity)).called(1);

      // Ensure no other interactions
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
