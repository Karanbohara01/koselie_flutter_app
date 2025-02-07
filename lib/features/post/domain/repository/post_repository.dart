import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';

abstract interface class IPostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, Unit>> createPost(PostEntity post);
  Future<Either<Failure, Unit>> deletePost(String postId);
}
