// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:koselie/app/usecase/usecase.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
// import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

// /// ✅ Use case for fetching comments of a post
// class GetCommentsUseCase
//     implements UsecaseWithParams<List<CommentEntity>, GetCommentsParams> {
//   final IPostsRepository postsRepository;

//   GetCommentsUseCase({required this.postsRepository});

//   @override
//   Future<Either<Failure, List<CommentEntity>>> call(GetCommentsParams params) {
//     return postsRepository.getComments(params.postId);
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

/// ✅ Params class for fetching comments
class GetCommentsParams extends Equatable {
  final String postId;

  const GetCommentsParams({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class GetCommentsUseCase
    implements UsecaseWithParams<List<CommentEntity>, GetCommentsParams> {
  final IPostsRepository postsRepository;
  final TokenSharedPrefs tokenSharedPrefs; // ✅ Inject Token Shared Prefs

  GetCommentsUseCase({
    required this.postsRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, List<CommentEntity>>> call(
      GetCommentsParams params) async {
    final tokenResult = await tokenSharedPrefs.getToken();

    return tokenResult.fold(
      (failure) {
        print("❌ Token retrieval failed: ${failure.message}");
        return Left(failure);
      },
      (token) async {
        print(
            "🛑 Retrieved token in GetCommentsUseCase: $token"); // ✅ Print token

        if (token == null || token.isEmpty) {
          print("❌ ERROR: No token retrieved from SharedPreferences!");
          return Left(ApiFailure(message: "No token provided!"));
        }

        return await postsRepository.getComments(
          params.postId,
          token, // ✅ Ensure token is passed
        );
      },
    );
  }
}
