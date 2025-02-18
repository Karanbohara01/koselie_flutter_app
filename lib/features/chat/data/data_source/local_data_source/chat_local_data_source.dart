// import 'package:koselie/core/network/hive_service.dart';
// import 'package:koselie/features/chat/data/model/message_hive_model.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';

// abstract class IChatLocalDataSource {
//   Future<void> saveMessage(MessageEntity message, String conversationId);
//   Future<List<MessageEntity>> getMessages(String conversationId);
//   Future<void> deleteMessage(String messageId);
// }

// class ChatLocalDataSource implements IChatLocalDataSource {
//   final HiveService _hiveService;

//   ChatLocalDataSource(this._hiveService);

//   @override
//   Future<void> saveMessage(MessageEntity message, String conversationId) async {
//     try {
//       final messageHiveModel = MessageHiveModel.fromEntity(
//           message, conversationId); // ✅ Pass conversationId
//       await _hiveService.saveMessage(messageHiveModel);
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<List<MessageEntity>> getMessages(String conversationId) async {
//     try {
//       final messages = await _hiveService.getMessages(conversationId);
//       return messages.map((msg) => msg.toEntity()).toList();
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<void> deleteMessage(String messageId) async {
//     try {
//       await _hiveService.deleteMessage(messageId);
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }
