import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/chat/domain/repository/message_repository.dart';

class DeleteMessageParams extends Equatable {
  final String messageId;

  const DeleteMessageParams({
    required this.messageId,
  });

  // Empty constructor
  const DeleteMessageParams.empty() : messageId = '_empty.string';

  @override
  List<Object?> get props => [messageId];
}

class DeleteMessageUseCase
    implements UsecaseWithParams<void, DeleteMessageParams> {
  final IChatRepository chatRepository;
  final TokenSharedPrefs tokenSharedPrefs; // ✅ Inject Token Shared Prefs

  DeleteMessageUseCase({
    required this.chatRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteMessageParams params) async {
    // ✅ Get token from Shared Preferences
    final tokenResult = await tokenSharedPrefs.getToken();

    return tokenResult.fold(
      (failure) => Left(failure), // ✅ Handle token retrieval failure
      (token) async {
        return await chatRepository.deleteMessage(
          token ?? '', // ✅ Ensure token is non-null
          params.messageId,
        );
      },
    );
  }
}
