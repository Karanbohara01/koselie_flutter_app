import 'dart:io';

import 'package:koselie/core/network/hive_service.dart';
import 'package:koselie/features/posts/data/data_source/posts_data_source.dart';
import 'package:koselie/features/posts/data/model/posts_hive_model.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

class PostsLocalDataSource implements IPostsDataSource {
  final HiveService hiveService;

  PostsLocalDataSource({required this.hiveService});

  @override
  Future<void> createPost(PostsEntity post) async {
    try {
      // Convert PostsEntity to PostsHiveModel
      final postsHiveModel = PostsHiveModel.fromEntity(post);
      await hiveService.createPost(postsHiveModel);
    } catch (e) {
      throw Exception('Error creating post in local storage: $e');
    }
  }

  @override
  Future<void> deletePost(String postId, String? token) async {
    try {
      await hiveService.deletePost(postId);
    } catch (e) {
      throw Exception('Error deleting post from local storage: $e');
    }
  }

  @override
  Future<List<PostsEntity>> getAllPosts() async {
    try {
      final postsHiveModels = await hiveService.getAllPosts();
      // Convert the Hive models back to the PostsEntity
      return postsHiveModels.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching posts from local storage: $e');
    }
  }

  @override
  Future<String> uploadImage(File file) async {
    // Local data source typically does not handle image uploads
    // But if you want to implement it for local storage, you could store the file on the device
    throw UnimplementedError('Local data source does not handle image uploads');
  }
}
