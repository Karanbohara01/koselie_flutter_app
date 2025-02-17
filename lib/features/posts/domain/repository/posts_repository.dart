import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

abstract interface class IPostsRepository {
  Future<Either<Failure, List<PostsEntity>>> getAllPosts();
  Future<Either<Failure, void>> createPost(PostsEntity post);
  Future<Either<Failure, void>> deletePost(String postId, String? token);
  Future<Either<Failure, String>> uploadImage(File file);
}
