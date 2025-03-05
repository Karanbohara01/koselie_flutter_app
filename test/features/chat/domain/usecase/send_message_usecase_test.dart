import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/domain/repository/message_repository.dart';
import 'package:koselie/features/chat/domain/usecase/send_message_usecase.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock dependencies
class MockChatRepository extends Mock implements IChatRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late SendMessageUseCase sendMessageUseCase;
  late MockChatRepository mockChatRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockChatRepository = MockChatRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    sendMessageUseCase = SendMessageUseCase(
      chatRepository: mockChatRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  // ✅ Sample message entity
  final testMessage = MessageEntity(
    senderId: "sender123",
    receiverId: "receiver123",
    message: "Hello!",
    createdAt: DateTime.now(), // Use DateTime.now() instead of null
  );

  const testReceiverId = "receiver123";
  const testToken = "mock_token";

  group('SendMessageUseCase', () {
    test(
        '✅ should send a message successfully when token retrieval is successful',
        () async {
      // Arrange: Mock token retrieval success
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(testToken));

      // Arrange: Mock repository success response
      when(() => mockChatRepository.sendMessage(
            testToken,
            testMessage,
            testReceiverId,
          )).thenAnswer((_) async => const Right(null));

      // Act
      final result = await sendMessageUseCase.call(
        SendMessageParams(message: testMessage, receiverId: testReceiverId),
      );

      // Assert
      expect(result, const Right(null));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockChatRepository.sendMessage(
            testToken,
            testMessage,
            testReceiverId,
          )).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockChatRepository);
    });

    test('❌ should return a Failure when token retrieval fails', () async {
      // Arrange: Simulate token retrieval failure
      var failure = Failure(message: '');
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await sendMessageUseCase.call(
        SendMessageParams(message: testMessage, receiverId: testReceiverId),
      );

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyZeroInteractions(
          mockChatRepository); // ✅ Ensure repository is not called
    });

    test('❌ should return a Failure when message sending fails', () async {
      // Arrange: Mock token retrieval success
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(testToken));

      // Arrange: Simulate message sending failure
      var failure = Failure(message: "");
      when(() => mockChatRepository.sendMessage(
            testToken,
            testMessage,
            testReceiverId,
          )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await sendMessageUseCase.call(
        SendMessageParams(message: testMessage, receiverId: testReceiverId),
      );

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockChatRepository.sendMessage(
            testToken,
            testMessage,
            testReceiverId,
          )).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockChatRepository);
    });
  });
}
