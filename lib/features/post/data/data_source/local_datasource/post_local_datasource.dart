import 'package:koselie/core/network/hive_service.dart';
import 'package:koselie/features/auth/data/model/post_hive_model.dart';
import 'package:koselie/features/post/data/data_source/post_datasource.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';

class PostLocalDatasource implements IPostDataSource {
  final HiveService _hiveService;
  PostLocalDatasource(this._hiveService);
  @override
  Future<void> createPost(PostEntity entity) async {
    try {
      // Convert PostEntity to PostHiveModel
      final postHiveModel = PostHiveModel.fromEntity(entity);
      await _hiveService.createPost(postHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await _hiveService.deletePost(postId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PostEntity>> getAllPosts() {
    try {
      return _hiveService.getAllPosts().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
