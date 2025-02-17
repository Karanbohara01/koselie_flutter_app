// chat_state.dart
part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final String? token;
  final List<MessageEntity> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.token,
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  /// ✅ **Initial State**
  factory ChatState.initial() {
    return const ChatState(
      token: null,
      messages: [],
      isLoading: false,
      error: null,
    );
  }

  /// ✅ **CopyWith Method**
  ChatState copyWith({
    String? token,
    List<MessageEntity>? messages,
    bool? isLoading,
    bool clearMessages = false, // ✅ Added to reset messages
    String? error,
  }) {
    return ChatState(
      token: token ?? this.token,
      messages: clearMessages ? [] : (messages ?? this.messages),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [token, messages, isLoading, error];
}
