import 'package:koselie/features/post/domain/entity/post_entity.dart';

abstract interface class IPostDataSource {
  Future<List<PostEntity>> getAllPosts();
  Future<void> createPost(PostEntity entity);
  Future<void> deletePost(String postId);
}
