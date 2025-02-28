import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

class PostsLocalRepository implements IPostsRepository {
  final PostsLocalDataSource _postsLocalDataSource;
  PostsLocalRepository({required PostsLocalDataSource postsLocalDataSource})
      : _postsLocalDataSource = postsLocalDataSource;

  @override
  Future<Either<Failure, void>> createPost(PostsEntity post, String? token) {
    try {
      _postsLocalDataSource.createPost(post, token);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId, String? token) {
    try {
      _postsLocalDataSource.deletePost(postId, token);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() {
    try {
      return _postsLocalDataSource.getAllPosts().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostsEntity>> getPostById(String postId) {
    // TODO: implement getPostById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePost(
      String postId, PostsEntity post, String? token) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
