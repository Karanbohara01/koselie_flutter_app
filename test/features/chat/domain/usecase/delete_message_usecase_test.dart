import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/domain/repository/message_repository.dart';
import 'package:koselie/features/chat/domain/usecase/delete_message_usecase.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock dependencies
class MockChatRepository extends Mock implements IChatRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late DeleteMessageUseCase deleteMessageUseCase;
  late MockChatRepository mockChatRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockChatRepository = MockChatRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    deleteMessageUseCase = DeleteMessageUseCase(
      chatRepository: mockChatRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  // ✅ Test data
  const testMessageId = "message_123";
  const testToken = "mock_token";

  group('DeleteMessageUseCase', () {
    test('✅ should delete a message successfully when token retrieval works',
        () async {
      // Arrange: Mock successful token retrieval
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(testToken));

      // Arrange: Mock repository success response
      when(() => mockChatRepository.deleteMessage(
            testToken,
            testMessageId,
          )).thenAnswer((_) async => const Right(null));

      // Act
      final result = await deleteMessageUseCase.call(
        const DeleteMessageParams(messageId: testMessageId),
      );

      // Assert
      expect(result, const Right(null));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockChatRepository.deleteMessage(
            testToken,
            testMessageId,
          )).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockChatRepository);
    });

    test('❌ should return a Failure when token retrieval fails', () async {
      // Arrange: Simulate token retrieval failure
      var failure = Failure(message: 'Token retrieval failed');
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await deleteMessageUseCase.call(
        const DeleteMessageParams(messageId: testMessageId),
      );

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyZeroInteractions(
          mockChatRepository); // ✅ Ensure repository is not called
    });

    test('❌ should return a Failure when message deletion fails', () async {
      // Arrange: Mock successful token retrieval
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(testToken));

      // Arrange: Simulate message deletion failure
      var failure = Failure(message: "Failed to delete message");
      when(() => mockChatRepository.deleteMessage(
            testToken,
            testMessageId,
          )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await deleteMessageUseCase.call(
        const DeleteMessageParams(messageId: testMessageId),
      );

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockChatRepository.deleteMessage(
            testToken,
            testMessageId,
          )).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockChatRepository);
    });
  });
}
