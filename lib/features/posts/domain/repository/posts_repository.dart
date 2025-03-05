import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

abstract interface class IPostsRepository {
  Future<Either<Failure, List<PostsEntity>>> getAllPosts();
  Future<Either<Failure, void>> createPost(PostsEntity post, String? token);
  Future<Either<Failure, void>> deletePost(String postId, String? token);
  Future<Either<Failure, String>> uploadImage(File file);

  /// ✅ Fetch a single post by ID
  Future<Either<Failure, PostsEntity>> getPostById(String postId);

  /// ✅ New: Update Post
  Future<Either<Failure, void>> updatePost(
      String postId, PostsEntity post, String? token);

  /// ✅ Add a comment to a post
  Future<Either<Failure, CommentEntity>> addComment(
      String postId, String commentText, String? token);

  /// ✅ Fetch comments of a post
  Future<Either<Failure, List<CommentEntity>>> getComments(
      String postId, String? token);
}
