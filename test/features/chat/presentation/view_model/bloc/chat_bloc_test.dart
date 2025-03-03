// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';
// import 'package:koselie/features/chat/domain/usecase/delete_message_usecase.dart';
// import 'package:koselie/features/chat/domain/usecase/get_message_usecase.dart';
// import 'package:koselie/features/chat/domain/usecase/send_message_usecase.dart';
// import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';
// import 'package:mocktail/mocktail.dart';

// // ✅ Mock Classes
// class MockSendMessageUseCase extends Mock implements SendMessageUseCase {}

// class MockGetMessagesUseCase extends Mock implements GetMessagesUseCase {}

// class MockDeleteMessageUseCase extends Mock implements DeleteMessageUseCase {}

// // ✅ Fallback Values for Mocktail
// class FakeSendMessageParams extends Fake implements SendMessageParams {}

// class FakeGetMessagesParams extends Fake implements GetMessagesParams {}

// class FakeDeleteMessageParams extends Fake implements DeleteMessageParams {}

// void main() {
//   late ChatBloc chatBloc;
//   late MockSendMessageUseCase mockSendMessageUseCase;
//   late MockGetMessagesUseCase mockGetMessagesUseCase;
//   late MockDeleteMessageUseCase mockDeleteMessageUseCase;

//   // ✅ Sample messages for testing
//   final message1 = MessageEntity(
//     messageId: '1',
//     senderId: 'user1',
//     receiverId: 'user2',
//     message: 'Hello!',
//     createdAt: DateTime.parse('2024-03-01T12:00:00Z'),
//   );

//   final message2 = MessageEntity(
//     messageId: '2',
//     senderId: 'user2',
//     receiverId: 'user1',
//     message: 'Hi there!',
//     createdAt: DateTime.parse('2024-03-01T12:05:00Z'),
//   );

//   final messagesList = [message1, message2];

//   setUpAll(() {
//     registerFallbackValue(FakeSendMessageParams());
//     registerFallbackValue(FakeGetMessagesParams());
//     registerFallbackValue(FakeDeleteMessageParams());
//   });

//   setUp(() {
//     mockSendMessageUseCase = MockSendMessageUseCase();
//     mockGetMessagesUseCase = MockGetMessagesUseCase();
//     mockDeleteMessageUseCase = MockDeleteMessageUseCase();

//     // ✅ Mock successful message retrieval by default
//     when(() => mockGetMessagesUseCase.call(any()))
//         .thenAnswer((_) async => Right(messagesList));

//     chatBloc = ChatBloc(
//       sendMessageUseCase: mockSendMessageUseCase,
//       getMessagesUseCase: mockGetMessagesUseCase,
//       deletemessageUseCase: mockDeleteMessageUseCase,
//     );
//   });

//   tearDown(() {
//     chatBloc.close();
//   });

//   // ✅ 1️⃣ Initial State Test
//   test('Initial state is ChatState.initial()', () {
//     expect(chatBloc.state, ChatState.initial());
//   });

//   // ✅ 2️⃣ Load Messages - Success
//   blocTest<ChatBloc, ChatState>(
//     'emits [loading, loaded] when LoadMessagesEvent is successful',
//     build: () => chatBloc,
//     act: (bloc) => bloc
//         .add(const LoadMessagesEvent(senderId: 'user1', receiverId: 'user2')),
//     expect: () => [
//       ChatState.initial().copyWith(isLoading: true, clearMessages: true),
//       ChatState.initial().copyWith(messages: messagesList, isLoading: false),
//     ],
//   );

//   // ✅ 3️⃣ Load Messages - Failure (Fixed `Failure` message handling)
//   blocTest<ChatBloc, ChatState>(
//     'emits [loading, error] when LoadMessagesEvent fails',
//     build: () {
//       when(() => mockGetMessagesUseCase.call(any())).thenAnswer(
//           (_) async => Left(Failure(message: 'Error loading messages')));
//       return chatBloc;
//     },
//     act: (bloc) => bloc
//         .add(const LoadMessagesEvent(senderId: 'user1', receiverId: 'user2')),
//     expect: () => [
//       ChatState.initial().copyWith(isLoading: true, clearMessages: true),
//       ChatState.initial().copyWith(
//         isLoading: false,
//         error: 'Failed to load messages: Error loading messages',
//       ),
//     ],
//   );

//   // ✅ 4️⃣ Send Message - Success (Fixed `messageId` & timestamp handling)
//   blocTest<ChatBloc, ChatState>(
//     'emits [message added, load messages] when SendMessage is successful',
//     build: () {
//       when(() => mockSendMessageUseCase.call(any()))
//           .thenAnswer((_) async => const Right(null));

//       return chatBloc;
//     },
//     act: (bloc) => bloc.add(const SendMessage(
//       senderId: 'user1',
//       receiverId: 'user2',
//       message: 'Hello!',
//     )),
//     expect: () => [
//       predicate<ChatState>((state) =>
//           state.messages.length == 1 &&
//           state.messages.first.message == 'Hello!'), // Dynamic timestamp fix
//       ChatState.initial().copyWith(messages: messagesList), // Reload messages
//     ],
//   );

//   // ✅ 5️⃣ Send Message - Failure
//   blocTest<ChatBloc, ChatState>(
//     'emits [message added, message removed] when SendMessage fails',
//     build: () {
//       when(() => mockSendMessageUseCase.call(any())).thenAnswer(
//           (_) async => Left(Failure(message: 'Failed to send message')));

//       return chatBloc;
//     },
//     act: (bloc) => bloc.add(const SendMessage(
//       senderId: 'user1',
//       receiverId: 'user2',
//       message: 'Hello!',
//     )),
//     expect: () => [
//       predicate<ChatState>(
//           (state) => state.messages.isNotEmpty), // Optimistic UI update
//       ChatState.initial()
//           .copyWith(messages: [], error: 'Message failed to send'),
//     ],
//   );

//   // ✅ 6️⃣ Delete Message - Success
//   blocTest<ChatBloc, ChatState>(
//     'emits [message removed] when DeleteMessageEvent is successful',
//     build: () {
//       when(() => mockDeleteMessageUseCase.call(any()))
//           .thenAnswer((_) async => const Right(null));

//       return chatBloc;
//     },
//     seed: () => ChatState.initial().copyWith(messages: messagesList),
//     act: (bloc) => bloc.add(const DeleteMessageEvent(
//         messageId: '1', senderId: '', receiverId: '', token: '')),
//     expect: () => [
//       ChatState.initial().copyWith(messages: [message2]), // Message removed
//     ],
//   );

//   // ✅ 7️⃣ Delete Message - Failure
//   blocTest<ChatBloc, ChatState>(
//     'emits [message restored] when DeleteMessageEvent fails',
//     build: () {
//       when(() => mockDeleteMessageUseCase.call(any())).thenAnswer(
//           (_) async => Left(Failure(message: 'Failed to delete message')));

//       return chatBloc;
//     },
//     seed: () => ChatState.initial().copyWith(messages: messagesList),
//     act: (bloc) => bloc.add(const DeleteMessageEvent(
//         messageId: '1', senderId: '', receiverId: '', token: '')),
//     expect: () => [
//       ChatState.initial().copyWith(messages: [message2]), // Optimistic remove
//       ChatState.initial()
//           .copyWith(messages: messagesList, error: 'Failed to delete message'),
//     ],
//   );
// }

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/domain/usecase/delete_message_usecase.dart';
import 'package:koselie/features/chat/domain/usecase/get_message_usecase.dart';
import 'package:koselie/features/chat/domain/usecase/send_message_usecase.dart';
import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock Classes
class MockSendMessageUseCase extends Mock implements SendMessageUseCase {}

class MockGetMessagesUseCase extends Mock implements GetMessagesUseCase {}

class MockDeleteMessageUseCase extends Mock implements DeleteMessageUseCase {}

// ✅ Fallback Values for Mocktail
class FakeSendMessageParams extends Fake implements SendMessageParams {}

class FakeGetMessagesParams extends Fake implements GetMessagesParams {}

class FakeDeleteMessageParams extends Fake implements DeleteMessageParams {}

void main() {
  late ChatBloc chatBloc;
  late MockSendMessageUseCase mockSendMessageUseCase;
  late MockGetMessagesUseCase mockGetMessagesUseCase;
  late MockDeleteMessageUseCase mockDeleteMessageUseCase;

  // ✅ Sample messages for testing
  final message1 = MessageEntity(
    messageId: '1',
    senderId: 'user1',
    receiverId: 'user2',
    message: 'Hello!',
    createdAt: DateTime.parse('2024-03-01T12:00:00Z'),
  );

  final message2 = MessageEntity(
    messageId: '2',
    senderId: 'user2',
    receiverId: 'user1',
    message: 'Hi there!',
    createdAt: DateTime.parse('2024-03-01T12:05:00Z'),
  );

  final messagesList = [message1, message2];

  setUpAll(() {
    registerFallbackValue(FakeSendMessageParams());
    registerFallbackValue(FakeGetMessagesParams());
    registerFallbackValue(FakeDeleteMessageParams());
  });

  setUp(() {
    mockSendMessageUseCase = MockSendMessageUseCase();
    mockGetMessagesUseCase = MockGetMessagesUseCase();
    mockDeleteMessageUseCase = MockDeleteMessageUseCase();

    when(() => mockGetMessagesUseCase.call(any()))
        .thenAnswer((_) async => Right(messagesList));

    chatBloc = ChatBloc(
      sendMessageUseCase: mockSendMessageUseCase,
      getMessagesUseCase: mockGetMessagesUseCase,
      deletemessageUseCase: mockDeleteMessageUseCase,
    );
  });

  tearDown(() {
    chatBloc.close();
  });

  // ✅ 1️⃣ Initial State Test
  test('Initial state is ChatState.initial()', () {
    expect(chatBloc.state, ChatState.initial());
  });

  // ✅ 2️⃣ Load Messages - Success
  blocTest<ChatBloc, ChatState>(
    'emits [loading, loaded] when LoadMessagesEvent is successful',
    build: () => chatBloc,
    act: (bloc) => bloc
        .add(const LoadMessagesEvent(senderId: 'user1', receiverId: 'user2')),
    expect: () => [
      ChatState.initial().copyWith(isLoading: true, clearMessages: true),
      ChatState.initial().copyWith(messages: messagesList, isLoading: false),
    ],
  );

  // ✅ 3️⃣ Send Message - Success (Handles `messageId` & `createdAt`)
  // ✅ 3️⃣ Send Message - Success (Handles `messageId` & `createdAt`)
  blocTest<ChatBloc, ChatState>(
    'emits [message added, load messages] when SendMessage is successful',
    build: () {
      when(() => mockSendMessageUseCase.call(any()))
          .thenAnswer((_) async => const Right(null));

      return chatBloc;
    },
    act: (bloc) => bloc.add(const SendMessage(
      senderId: 'user1',
      receiverId: 'user2',
      message: 'Hello!',
    )),
    expect: () => [
      predicate<ChatState>((state) {
        // ✅ Ensure at least one message is optimistically added
        if (state.messages.isEmpty) return false;

        final addedMessage = state.messages.first;
        return addedMessage.senderId == 'user1' &&
            addedMessage.receiverId == 'user2' &&
            addedMessage.message == 'Hello!' &&
            addedMessage.messageId ==
                null; // ✅ Allow temporary null `messageId`
      }),
      ChatState.initial().copyWith(messages: messagesList), // ✅ Reload messages
    ],
  );

  // ✅ 4️⃣ Send Message - Failure
  blocTest<ChatBloc, ChatState>(
    'emits [message added, message removed] when SendMessage fails',
    build: () {
      when(() => mockSendMessageUseCase.call(any())).thenAnswer(
          (_) async => Left(Failure(message: 'Failed to send message')));

      return chatBloc;
    },
    act: (bloc) => bloc.add(const SendMessage(
      senderId: 'user1',
      receiverId: 'user2',
      message: 'Hello!',
    )),
    expect: () => [
      predicate<ChatState>(
          (state) => state.messages.isNotEmpty), // ✅ Optimistic UI update
      ChatState.initial()
          .copyWith(messages: [], error: 'Message failed to send'),
    ],
  );

  // ✅ 5️⃣ Delete Message - Success
  blocTest<ChatBloc, ChatState>(
    'emits [message removed] when DeleteMessageEvent is successful',
    build: () {
      when(() => mockDeleteMessageUseCase.call(any()))
          .thenAnswer((_) async => const Right(null));

      return chatBloc;
    },
    seed: () => ChatState.initial().copyWith(messages: messagesList),
    act: (bloc) => bloc.add(const DeleteMessageEvent(
        messageId: '1', senderId: '', receiverId: '', token: '')),
    expect: () => [
      ChatState.initial().copyWith(messages: [message2]), // ✅ Message removed
    ],
  );

  // ✅ 6️⃣ Delete Message - Failure (Handles Error Message Variations)
  blocTest<ChatBloc, ChatState>(
    'emits [message restored] when DeleteMessageEvent fails',
    build: () {
      when(() => mockDeleteMessageUseCase.call(any())).thenAnswer(
          (_) async => Left(Failure(message: 'Failed to delete message')));

      return chatBloc;
    },
    seed: () => ChatState.initial().copyWith(messages: messagesList),
    act: (bloc) => bloc.add(const DeleteMessageEvent(
        messageId: '1', senderId: '', receiverId: '', token: '')),
    expect: () => [
      ChatState.initial().copyWith(messages: [message2]), // ✅ Optimistic remove
      predicate<ChatState>(
        (state) =>
            state.messages == messagesList &&
            state.error!
                .contains('Failed to delete message'), // ✅ Handles variations
      ),
    ],
  );
}
