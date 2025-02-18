part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

/// ✅ Delete Message Event
class DeleteMessageEvent extends ChatEvent {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String token;

  const DeleteMessageEvent({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.token,
  });

  @override
  List<Object?> get props => [messageId, senderId, receiverId, token];
}

/// ✅ Load Authentication Token Event
class LoadTokenEvent extends ChatEvent {}

/// ✅ Load Messages for a Selected Receiver
class LoadMessagesEvent extends ChatEvent {
  final String senderId;
  final String receiverId;

  const LoadMessagesEvent({
    required this.senderId,
    required this.receiverId,
  });

  @override
  List<Object?> get props => [senderId, receiverId];
}

/// ✅ Send Message Event
class SendMessage extends ChatEvent {
  final String senderId;
  final String receiverId;
  final String message;

  const SendMessage({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object?> get props => [senderId, receiverId, message];
}
