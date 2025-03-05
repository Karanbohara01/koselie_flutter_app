import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:koselie/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock UseCases
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUseCase extends Mock implements UploadImageUsecase {}

// Mock File
class MockFile extends Mock implements File {}

// Mock BuildContext
class MockBuildContext extends Mock implements BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

void main() {
  late RegisterBloc registerBloc;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockUploadImageUseCase mockUploadImageUseCase;

  setUpAll(() {
    // Register fallback values for custom classes
    registerFallbackValue(const RegisterUserParams(
      username: 'fallback',
      password: 'fallback',
      email: 'fallback@example.com',
      image: 'fallback_image',
    ));

    registerFallbackValue(UploadImageParams(
      file: MockFile(),
    ));
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockUploadImageUseCase = MockUploadImageUseCase();
    registerBloc = RegisterBloc(
      registerUseCase: mockRegisterUseCase,
      uploadImageUsecase: mockUploadImageUseCase,
    );
  });

  tearDown(() {
    registerBloc.close();
  });

  test('initial state should be RegisterState.initial()', () {
    expect(registerBloc.state, const RegisterState.initial());
  });

  blocTest<RegisterBloc, RegisterState>(
    'emits [loading, failure] when RegisterUser event is added and registration fails',
    build: () {
      when(() => mockRegisterUseCase.call(any())).thenAnswer(
        (_) async => Left(ApiFailure(message: 'Registration failed')),
      );
      return registerBloc;
    },
    seed: () => const RegisterState(
      isLoading: false,
      isSuccess: false,
      imageUploaded: true,
      imageName: 'uploaded_image.jpg',
    ),
    act: (bloc) => bloc.add(RegisterUser(
      username: 'test_user',
      password: 'test_pass',
      email: 'test@example.com',
      context: MockBuildContext(),
    )),
    expect: () => [
      const RegisterState(
        isLoading: true,
        isSuccess: false,
        imageUploaded: true,
        imageName: 'uploaded_image.jpg',
      ),
      const RegisterState(
        isLoading: false,
        isSuccess: false,
        imageUploaded: true,
        imageName: 'uploaded_image.jpg',
      ),
    ],
    verify: (_) {
      verify(() => mockRegisterUseCase.call(any())).called(1);
    },
  );
}
