import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/get_all_users_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late GetAllUsersUseCase usecase;
  late MockRegisterRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockRegisterRepository();
    usecase = GetAllUsersUseCase(mockAuthRepository);
  });

  final tAuthEntities = [
    const AuthEntity(
        username: 'user1', email: 'user1@example.com', password: "password"),
    const AuthEntity(
        username: 'user2', email: 'user2@example.com', password: 'password'),
  ];

  test(
    'Should return a list of AuthEntities when getAllUsers is successful',
    () async {
      // Arrange
      when(() => mockAuthRepository.getAllUsers())
          .thenAnswer((_) async => Right(tAuthEntities));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Right(tAuthEntities));

      // Verify
      verify(() => mockAuthRepository.getAllUsers()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return a Failure when getAllUsers fails',
    () async {
      // Arrange
      final tFailure = ServerFailure(message: 'Failed to get all users.');
      when(() => mockAuthRepository.getAllUsers())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(tFailure));

      // Verify
      verify(() => mockAuthRepository.getAllUsers()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
