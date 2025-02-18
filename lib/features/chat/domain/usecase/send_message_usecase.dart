import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/domain/repository/message_repository.dart';

class SendMessageParams extends Equatable {
  final MessageEntity message;
  final String receiverId;

  const SendMessageParams({
    required this.message,
    required this.receiverId,
  });

  // Empty constructor
  SendMessageParams.empty()
      : message = MessageEntity.empty(),
        receiverId = '_empty_string';

  @override
  List<Object?> get props => [message, receiverId];
}

class SendMessageUseCase implements UsecaseWithParams<void, SendMessageParams> {
  final IChatRepository chatRepository;
  final TokenSharedPrefs tokenSharedPrefs; // ✅ Inject Token Shared Prefs

  SendMessageUseCase({
    required this.chatRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    // ✅ Get token from Shared Preferences
    final tokenResult = await tokenSharedPrefs.getToken();

    return tokenResult.fold(
      (failure) => Left(failure), // ✅ Handle token retrieval failure
      (token) async {
        return await chatRepository.sendMessage(
          token ?? '', // ✅ Ensure token is non-null
          params.message,
          params.receiverId,
        );
      },
    );
  }
}
