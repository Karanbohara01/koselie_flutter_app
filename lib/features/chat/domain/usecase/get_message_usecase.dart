import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/domain/repository/message_repository.dart';

class GetMessagesParams extends Equatable {
  final String senderId;
  final String receiverId;

  const GetMessagesParams({
    required this.senderId,
    required this.receiverId,
  });

  @override
  List<Object?> get props => [senderId, receiverId];
}

class GetMessagesUseCase
    implements UsecaseWithParams<List<MessageEntity>, GetMessagesParams> {
  final IChatRepository chatRepository;
  final TokenSharedPrefs tokenSharedPrefs; // ✅ Inject Token Shared Prefs

  GetMessagesUseCase({
    required this.chatRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, List<MessageEntity>>> call(
      GetMessagesParams params) async {
    // ✅ Get token from Shared Preferences
    final tokenResult = await tokenSharedPrefs.getToken();

    return tokenResult.fold(
      (failure) => Left(failure), // ✅ Handle token retrieval failure
      (token) async {
        return await chatRepository.getMessages(
          token ?? '', // ✅ Ensure token is non-null
          params.senderId,
          params.receiverId,
        );
      },
    );
  }
}
