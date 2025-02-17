import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? messageId;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt; // ✅ Added createdAt

  const MessageEntity({
    this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt, // ✅ Ensure required in constructor
  });

  // Empty factory constructor
  factory MessageEntity.empty() {
    return MessageEntity(
      messageId: '_empty_string',
      message: '_empty_string',
      senderId: '_empty_string',
      receiverId: '_empty_string',
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props =>
      [messageId, senderId, receiverId, message, createdAt];
}
