import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'upload.mock.dart';

void main() {
  late UploadImageUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UploadImageUsecase(mockAuthRepository);
  });

  const tImageUrl = 'https://example.com/image.jpg'; // Sample image URL
  final tFile = File('path/to/dummy_image.jpg');

  test(
    'Should return an image URL when uploadProfilePicture is successful',
    () async {
      // Arrange: Setup the mock to return a Right(tImageUrl)

      when(() => mockAuthRepository.uploadProfilePicture(tFile))
          .thenAnswer((_) async => const Right(tImageUrl));

      // Act: Call the use case
      final result = await usecase(UploadImageParams(file: tFile));

      // Assert: Check if the result is Right(tImageUrl)
      expect(result, const Right(tImageUrl));

      // Verify that the repository method was called with the correct File
      verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);

      // Ensure no other interactions occurred with the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'Should return a Failure when uploadProfilePicture fails',
    () async {
      // Arrange: Setup the mock to return a Left(ServerFailure)
      final tFailure = ServerFailure(
          message:
              'Failed to upload image.'); // Remove const.  It's not constant.
      when(() => mockAuthRepository.uploadProfilePicture(tFile)).thenAnswer(
          (_) async => Left(tFailure)); // Remove const.  It's not constant.

      // Act: Call the use case
      final result = await usecase(UploadImageParams(file: tFile));

      // Assert: Check if the result is Left(ServerFailure)
      expect(result, Left(tFailure)); // Remove const.  It's not constant.

      // Verify that the repository method was called with the correct File
      verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);

      // Ensure no other interactions occurred with the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
