import 'dart:io';

import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

abstract interface class IPostsDataSource {
  Future<List<PostsEntity>> getAllPosts();
  Future<void> createPost(PostsEntity post, String? token);
  Future<void> deletePost(String postId, String? token);
  Future<String> uploadImage(File file);

  /// ✅ Fetch a single post by ID
  Future<PostsEntity> getPostById(String postId);

  Future<void> updatePost(String postId, PostsEntity post, String? token);

  /// ✅ Add a comment to a post
  Future<CommentEntity> addComment(
      String postId, String commentText, String? token);

  /// ✅ Fetch comments of a post
  Future<List<CommentEntity>> getComments(String postId, String? token);
}
