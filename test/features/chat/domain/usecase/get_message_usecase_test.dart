import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/domain/repository/message_repository.dart';
import 'package:koselie/features/chat/domain/usecase/get_message_usecase.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock dependencies
class MockChatRepository extends Mock implements IChatRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late GetMessagesUseCase getMessagesUseCase;
  late MockChatRepository mockChatRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockChatRepository = MockChatRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    getMessagesUseCase = GetMessagesUseCase(
      chatRepository: mockChatRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  // ✅ Sample message list
  final testMessages = [
    MessageEntity(
      senderId: "sender123",
      receiverId: "receiver123",
      message: "Hello!",
      createdAt: DateTime.now(),
    ),
    MessageEntity(
      senderId: "receiver123",
      receiverId: "sender123",
      message: "Hey, how are you?",
      createdAt: DateTime.now(),
    ),
  ];

  const testSenderId = "sender123";
  const testReceiverId = "receiver123";
  const testToken = "mock_token";

  group('GetMessagesUseCase', () {
    test('✅ should fetch messages successfully when token retrieval works',
        () async {
      // Arrange: Mock successful token retrieval
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(testToken));

      // Arrange: Mock repository success response
      when(() => mockChatRepository.getMessages(
            testToken,
            testSenderId,
            testReceiverId,
          )).thenAnswer((_) async => Right(testMessages));

      // Act
      final result = await getMessagesUseCase.call(
        const GetMessagesParams(
            senderId: testSenderId, receiverId: testReceiverId),
      );

      // Assert
      expect(result, Right(testMessages));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockChatRepository.getMessages(
            testToken,
            testSenderId,
            testReceiverId,
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
      final result = await getMessagesUseCase.call(
        const GetMessagesParams(
            senderId: testSenderId, receiverId: testReceiverId),
      );

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyZeroInteractions(
          mockChatRepository); // ✅ Ensure repository is not called
    });

    test('❌ should return a Failure when message fetching fails', () async {
      // Arrange: Mock successful token retrieval
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(testToken));

      // Arrange: Simulate message fetching failure
      var failure = Failure(message: "Failed to fetch messages");
      when(() => mockChatRepository.getMessages(
            testToken,
            testSenderId,
            testReceiverId,
          )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await getMessagesUseCase.call(
        const GetMessagesParams(
            senderId: testSenderId, receiverId: testReceiverId),
      );

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockChatRepository.getMessages(
            testToken,
            testSenderId,
            testReceiverId,
          )).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockChatRepository);
    });
  });
}
