import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

class DeletePostsParams extends Equatable {
  final String postId;

  const DeletePostsParams({required this.postId});

  const DeletePostsParams.empty() : postId = '_empty.string';

  @override
  List<Object?> get props => [
        postId,
      ];
}

class DeletePostsUsecase implements UsecaseWithParams<void, DeletePostsParams> {
  final IPostsRepository postsRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeletePostsUsecase({
    required this.postsRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeletePostsParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await postsRepository.deletePost(params.postId, r);
    });
  }
}
