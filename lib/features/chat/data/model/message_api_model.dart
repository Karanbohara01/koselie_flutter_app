// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';

// part 'message_api_model.g.dart';

// @JsonSerializable()
// class MessageModel extends Equatable {
//   @JsonKey(name: "_id")
//   final String? messageId;
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime createdAt;

//   const MessageModel({
//     this.messageId,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.createdAt,
//   });

//   /// ✅ Convert JSON to Model
//   factory MessageModel.fromJson(Map<String, dynamic> json) =>
//       _$MessageModelFromJson(json);

//   /// ✅ Convert Model to JSON
//   Map<String, dynamic> toJson() => _$MessageModelToJson(this);

//   /// ✅ Convert to Domain Entity
//   MessageEntity toEntity() {
//     return MessageEntity(
//       messageId: messageId,
//       senderId: senderId,
//       receiverId: receiverId,
//       message: message,
//       createdAt: createdAt,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [messageId, senderId, receiverId, message, createdAt];
// }

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';

part 'message_api_model.g.dart';

@JsonSerializable()
class MessageModel extends Equatable {
  @JsonKey(name: "_id")
  final String? messageId;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt;

  const MessageModel({
    this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
  });

  /// ✅ **Convert JSON to Model (Handles Null Values)**
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json["_id"]?.toString(), // ✅ Ensure it's a String or null
      senderId:
          json['senderId']?.toString() ?? "Unknown Sender", // ✅ Handle null
      receiverId:
          json['receiverId']?.toString() ?? "Unknown Receiver", // ✅ Handle null
      message: json['message'] ?? "[No message]", // ✅ Default text if missing
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ??
              DateTime.now() // ✅ Parse safely
          : DateTime.now(), // ✅ Default to now if missing
    );
  }

  /// ✅ Convert Model to JSON
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  /// ✅ Convert to Domain Entity
  MessageEntity toEntity() {
    return MessageEntity(
      messageId: messageId,
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [messageId, senderId, receiverId, message, createdAt];
}
