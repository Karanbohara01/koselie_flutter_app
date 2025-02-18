// import 'package:equatable/equatable.dart';
// import 'package:hive/hive.dart';
// import 'package:koselie/app/constants/hive_table_constant.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';
// import 'package:uuid/uuid.dart';

// part 'message_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.messageTableId)
// class MessageHiveModel extends Equatable {
//   @HiveField(0)
//   final String? messageId;

//   @HiveField(1)
//   final String senderId;

//   @HiveField(2)
//   final String receiverId;

//   @HiveField(3)
//   final String message;

//   @HiveField(4) // ✅ Add this field
//   final String conversationId; // ✅ New Field

//   // ✅ Constructor
//   MessageHiveModel({
//     String? messageId,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.conversationId, // ✅ Include in Constructor
//   }) : messageId = messageId ?? const Uuid().v4();

//   // ✅ Convert Entity to Hive Model
//   factory MessageHiveModel.fromEntity(
//       MessageEntity entity, String conversationId) {
//     return MessageHiveModel(
//       messageId: entity.messageId,
//       senderId: entity.senderId,
//       receiverId: entity.receiverId,
//       message: entity.message,
//       conversationId: conversationId, // ✅ Assign conversationId
//     );
//   }

//   // ✅ Convert Hive Model back to Entity
//   MessageEntity toEntity() {
//     return MessageEntity(
//       messageId: messageId,
//       senderId: senderId,
//       receiverId: receiverId,
//       message: message,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [messageId, senderId, receiverId, message, conversationId];
// }
