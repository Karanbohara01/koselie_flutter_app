// import 'package:dartz/dartz.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/chat/data/data_source/local_data_source/chat_local_data_source.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';
// import 'package:koselie/features/chat/domain/repository/message_repository.dart';

// class ChatLocalRepository implements IChatRepository {
//   final ChatLocalDataSource _chatLocalDataSource;

//   ChatLocalRepository(this._chatLocalDataSource);

//   @override
//   Future<Either<Failure, void>> sendMessage(
//       MessageEntity message, String conversationId) async {
//     try {
//       await _chatLocalDataSource.saveMessage(
//           message, conversationId); // ✅ Pass conversationId
//       return const Right(null);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, List<MessageEntity>>> getMessages(
//       String conversationId) async {
//     try {
//       final messages = await _chatLocalDataSource.getMessages(conversationId);
//       return Right(messages);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteMessage(String messageId) async {
//     try {
//       await _chatLocalDataSource.deleteMessage(messageId);
//       return const Right(null);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }
// }
