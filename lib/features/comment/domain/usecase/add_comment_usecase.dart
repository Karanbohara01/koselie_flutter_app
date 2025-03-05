import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

/// ✅ Params class for adding a comment
class AddCommentParams extends Equatable {
  final String postId;
  final String text;

  const AddCommentParams({required this.postId, required this.text});

  // Empty constructor
  const AddCommentParams.empty()
      : postId = '_empty.postId',
        text = '_empty.text';

  @override
  List<Object?> get props => [postId, text];
}

/// ✅ Use case for adding a comment
class AddCommentUseCase
    implements UsecaseWithParams<CommentEntity, AddCommentParams> {
  final IPostsRepository postsRepository;
  final TokenSharedPrefs tokenSharedPrefs; // ✅ Inject Token Shared Prefs

  AddCommentUseCase({
    required this.postsRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, CommentEntity>> call(AddCommentParams params) async {
    // ✅ Get token from Shared Preferences
    final tokenResult = await tokenSharedPrefs.getToken();

    return tokenResult.fold(
      (failure) => Left(failure), // ✅ Handle token retrieval failure
      (token) async {
        return await postsRepository.addComment(
          params.postId,
          params.text,
          token ?? '', // ✅ Pass token to repository
        );
      },
    );
  }
}
