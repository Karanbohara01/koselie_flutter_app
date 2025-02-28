// Test Code
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/features/auth/domain/usecase/delete_profile_picture_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late DeleteProfilePictureUseCase usecase;
  late MockRegisterRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockRegisterRepository();
    usecase = DeleteProfilePictureUseCase(mockAuthRepository);
  });

  test(
    'Should call the repository and return Right(void) on successful deletion',
    () async {
      // Arrange
      when(() => mockAuthRepository.deleteProfilePicture())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase();

      // Assert
      expect(result, const Right(null));

      // Verify
      verify(() => mockAuthRepository.deleteProfilePicture()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  // test(
  //   'Should return a Failure when profile picture deletion fails',
  //   () async {
  //     // Arrange
  //     final tFailure =
  //         ServerFailure(message: 'Failed to delete profile picture.');
  //     when(() => mockAuthRepository.deleteProfilePicture())
  //         .thenAnswer((_) async => Left(tFailure));

  //     // Act
  //     final result = await usecase();

  //     // Assert
  //     expect(result, Left(tFailure));

  //     // Verify
  //     verify(() => mockAuthRepository.deleteProfilePicture()).called(1);
  //     verifyNoMoreInteractions(mockAuthRepository);
  //   },
  // );
}
