import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';

abstract interface class IPostRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, void>> createPost(PostEntity post);
  Future<Either<Failure, void>> deletePost(String postId);
}
