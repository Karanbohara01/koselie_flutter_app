import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/data/data_source/remote_data_source/chat_remote_data_source.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/domain/repository/message_repository.dart';

class ChatRemoteRepository implements IChatRepository {
  final ChatRemoteDataSource _chatRemoteDatasource;

  ChatRemoteRepository(this._chatRemoteDatasource);

  @override
  Future<Either<Failure, void>> sendMessage(
      String token, MessageEntity message, String receiverId) async {
    try {
      await _chatRemoteDatasource.sendMessage(token, message, receiverId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages(
      String token, String senderId, String receiverId) async {
    try {
      final messages =
          await _chatRemoteDatasource.getMessages(token, senderId, receiverId);
      return Right(messages);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(
      String token, String messageId) async {
    try {
      await _chatRemoteDatasource.deleteMessage(token, messageId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
