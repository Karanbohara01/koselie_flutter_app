import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/post/data/data_source/local_datasource/post_local_datasource.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';
import 'package:koselie/features/post/domain/repository/post_repository.dart';

class PostLocalRepository implements IPostRepository {
  final PostLocalDatasource _postLocalDatasource;

  PostLocalRepository({required PostLocalDatasource postLocalDataSource})
      : _postLocalDatasource = postLocalDataSource;

  @override
  Future<Either<Failure, void>> createPost(PostEntity post) {
    try {
      _postLocalDatasource.createPost(post);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    try {
      await _postLocalDatasource.deletePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: "Error Deleting post : $e"),
      );
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try {
      final posts = await _postLocalDatasource.getAllPosts();
      return Right(posts);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: "Error getting all posts: $e"),
      );
    }
  }
}
