import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

class UpdatePostsParams extends Equatable {
  final String postId;
  final PostsEntity post;

  const UpdatePostsParams({required this.postId, required this.post});

  @override
  List<Object?> get props => [postId, post];
}

class UpdatePostsUsecase implements UsecaseWithParams<void, UpdatePostsParams> {
  final IPostsRepository postsRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdatePostsUsecase({
    required this.postsRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(UpdatePostsParams params) async {
    // Get token from Shared Preferences
    final token = await tokenSharedPrefs.getToken();
    return token.fold(
      (failure) => Left(failure),
      (tokenValue) async {
        return await postsRepository.updatePost(
            params.postId, params.post, tokenValue);
      },
    );
  }
}
