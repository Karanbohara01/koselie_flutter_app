import 'dart:io';

import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

abstract interface class IPostsDataSource {
  Future<List<PostsEntity>> getAllPosts();
  Future<void> createPost(PostsEntity post, String? token);
  Future<void> deletePost(String postId, String? token);
  Future<String> uploadImage(File file);

  /// ✅ Fetch a single post by ID
  Future<PostsEntity> getPostById(String postId);
}
