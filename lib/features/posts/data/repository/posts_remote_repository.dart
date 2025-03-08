import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

class PostsRemoteRepository implements IPostsRepository {
  final PostsRemoteDataSource remoteDataSource;

  PostsRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createPost(
      PostsEntity post, String? token) async {
    try {
      remoteDataSource.createPost(post, token);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId, String? token) async {
    try {
      remoteDataSource.deletePost(postId, token);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
    try {
      final posts = await remoteDataSource.getAllPosts();
      return Right(posts);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) async {
    try {
      final imageName = await remoteDataSource.uploadImage(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Fetch a single post by ID
  @override
  Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
    try {
      final post = await remoteDataSource.getPostById(postId);
      return Right(post);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

//  add getPostById here
