// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

// class PostsRemoteRepository implements IPostsRepository {
//   final PostsRemoteDataSource remoteDataSource;

//   PostsRemoteRepository({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, void>> createPost(
//       PostsEntity post, String? token) async {
//     try {
//       remoteDataSource.createPost(post, token);
//       return const Right(null);
//     } catch (e) {
//       return Left(
//         ApiFailure(
//           message: e.toString(),
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deletePost(String postId, String? token) async {
//     try {
//       remoteDataSource.deletePost(postId, token);
//       return const Right(null);
//     } catch (e) {
//       return Left(
//         ApiFailure(
//           message: e.toString(),
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
//     try {
//       final posts = await remoteDataSource.getAllPosts();
//       return Right(posts);
//     } catch (e) {
//       return Left(
//         ApiFailure(
//           message: e.toString(),
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadImage(File file) async {
//     try {
//       final imageName = await remoteDataSource.uploadImage(file);
//       return Right(imageName);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   /// ✅ Fetch a single post by ID
//   @override
//   Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
//     try {
//       final post = await remoteDataSource.getPostById(postId);
//       return Right(post);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> updatePost(
//       String postId, PostsEntity post, String? token) async {
//     try {
//       await remoteDataSource.updatePost(postId, post, token);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
// }

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart'; // Import local data source
import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';
import 'package:koselie/features/posts/service/connectivity_service.dart';

class PostsRemoteRepository implements IPostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource; // Add local data source
  final ConnectivityService connectivityService;

  PostsRemoteRepository({
    required this.remoteDataSource,
    required this.localDataSource, // Initialize local data source
    required this.connectivityService,
  });

  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
    try {
      if (await connectivityService.isConnected()) {
        // Has internet, fetch from remote data source
        final posts = await remoteDataSource.getAllPosts();
        return Right(posts);
      } else {
        // No internet, fetch from local data source (Hive)
        try {
          final localPosts = await localDataSource.getAllPosts();
          return Right(localPosts);
        } catch (localError) {
          // Handle local data source error (e.g., Hive not initialized)
          return Left(LocalDatabaseFailure(
              message: 'Error fetching from local database: $localError'));
        }
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createPost(
      PostsEntity post, String? token) async {
    try {
      if (await connectivityService.isConnected()) {
        await remoteDataSource.createPost(post, token);
        return const Right(null);
      } else {
        // No internet: save locally (Hive)
        try {
          await localDataSource.createPost(post, token); // Save to Hive
          return const Right(null);
        } catch (localError) {
          return Left(LocalDatabaseFailure(
              message: 'Error saving post locally: $localError'));
        }
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId, String? token) async {
    try {
      if (await connectivityService.isConnected()) {
        await remoteDataSource.deletePost(postId, token);
        return const Right(null);
      } else {
        // No internet: delete locally (Hive)
        try {
          await localDataSource.deletePost(postId, token); // Delete from Hive
          return const Right(null);
        } catch (localError) {
          return Left(LocalDatabaseFailure(
              message: 'Error deleting post locally: $localError'));
        }
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) async {
    // Decide how to handle image uploads offline.  Options:
    // 1. Return an error (not supported offline).
    // 2. Store the image locally and upload later (more complex).
    if (await connectivityService.isConnected()) {
      try {
        final imageName = await remoteDataSource.uploadImage(file);
        return Right(imageName);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return Left(
          ApiFailure(message: 'Image upload not supported in offline mode.'));
    }
  }

  @override
  Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
    try {
      if (await connectivityService.isConnected()) {
        final post = await remoteDataSource.getPostById(postId);
        return Right(post);
      } else {
        // No internet: fetch from local data source (Hive)
        // Assuming localDataSource.getPostById is implemented
        try {
          final localPost = await localDataSource.getPostById(postId);
          return Right(localPost);
        } catch (localError) {
          return Left(LocalDatabaseFailure(
              message: 'Error fetching post locally: $localError'));
        }
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(
      String postId, PostsEntity post, String? token) async {
    try {
      if (await connectivityService.isConnected()) {
        await remoteDataSource.updatePost(postId, post, token);
        return const Right(null);
      } else {
        // No internet: update locally (Hive)
        // Assuming localDataSource.updatePost is implemented
        try {
          await localDataSource.updatePost(postId, post, token);
          return const Right(null);
        } catch (localError) {
          return Left(LocalDatabaseFailure(
              message: 'Error updating post locally: $localError'));
        }
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
