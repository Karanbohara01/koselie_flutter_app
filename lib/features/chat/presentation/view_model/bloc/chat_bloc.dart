import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/domain/usecase/delete_message_usecase.dart';
import 'package:koselie/features/chat/domain/usecase/get_message_usecase.dart';
import 'package:koselie/features/chat/domain/usecase/send_message_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase _sendMessageUseCase;
  final GetMessagesUseCase _getMessagesUseCase;
  final DeleteMessageUseCase _deleteMessageUseCase; // ✅ Inject delete use case

  ChatBloc({
    required SendMessageUseCase sendMessageUseCase,
    required GetMessagesUseCase getMessagesUseCase,
    required DeleteMessageUseCase deletemessageUseCase,
  })  : _sendMessageUseCase = sendMessageUseCase,
        _getMessagesUseCase = getMessagesUseCase,
        _deleteMessageUseCase = deletemessageUseCase,
        super(ChatState.initial()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<DeleteMessageEvent>(_onDeleteMessage); // ✅ Handle delete event
  }

  /// ✅ **Load Messages (Both Sent and Received)**
  Future<void> _onLoadMessages(
      LoadMessagesEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(clearMessages: true, isLoading: true));

    final params = GetMessagesParams(
      senderId: event.senderId,
      receiverId: event.receiverId,
    );
    final result = await _getMessagesUseCase.call(params);
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          error: "Failed to load messages: ${failure.message}")),
      (messages) {
        // ✅ Sort messages by timestamp
        messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        emit(state.copyWith(
          isLoading: false,
          messages: messages,
          error: null,
        ));
      },
    );
  }

  /// ✅ **Send Message & Refresh Messages**
  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    final newMessage = MessageEntity(
      senderId: event.senderId,
      receiverId: event.receiverId,
      message: event.message,
      createdAt: DateTime.now(),
    );

    // ✅ Optimistically update UI with new message
    final updatedMessages = [...state.messages, newMessage];
    emit(state.copyWith(messages: updatedMessages, error: null));

    try {
      final result = await _sendMessageUseCase.call(SendMessageParams(
        message: newMessage,
        receiverId: event.receiverId,
      ));

      result.fold(
        (failure) {
          // ❌ If sending fails, revert UI and keep other messages intact
          final revertedMessages =
              state.messages.where((msg) => msg != newMessage).toList();
          emit(state.copyWith(
              messages: revertedMessages, error: "Message failed to send"));
        },
        (success) {
          // ✅ If sending succeeds, **refresh messages** to get latest messages
          add(LoadMessagesEvent(
              senderId: event.senderId, receiverId: event.receiverId));
        },
      );
    } catch (e) {
      // ❌ Handle unexpected API errors
      final revertedMessages =
          state.messages.where((msg) => msg != newMessage).toList();
      emit(state.copyWith(
          messages: revertedMessages,
          error: 'Unexpected error: ${e.toString()}'));
    }
  }

  /// ✅ **Delete Message**
  Future<void> _onDeleteMessage(
      DeleteMessageEvent event, Emitter<ChatState> emit) async {
    final originalMessages = state.messages;

    // ✅ Optimistically remove the message from UI
    final updatedMessages = state.messages
        .where((msg) => msg.messageId != event.messageId)
        .toList();
    emit(state.copyWith(messages: updatedMessages, error: null));

    final result = await _deleteMessageUseCase.call(DeleteMessageParams(
      messageId: event.messageId,
    ));

    result.fold(
      (failure) {
        // ❌ If deletion fails, revert the UI
        emit(state.copyWith(
          messages: originalMessages,
          error: "Failed to delete message: ${failure.message}",
        ));
      },
      (success) {
        // ✅ If success, keep the UI as is (message already removed)
      },
    );
  }
}
