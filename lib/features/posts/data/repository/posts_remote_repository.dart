// // import 'dart:io';

// // import 'package:dartz/dartz.dart';
// // import 'package:koselie/core/error/failure.dart';
// // import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart'; // Import local data source
// // import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
// // import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// // import 'package:koselie/features/posts/domain/repository/posts_repository.dart';
// // import 'package:koselie/features/posts/service/connectivity_service.dart';

// // class PostsRemoteRepository implements IPostsRepository {
// //   final PostsRemoteDataSource remoteDataSource;
// //   final PostsLocalDataSource localDataSource; // Add local data source
// //   final ConnectivityService connectivityService;

// //   PostsRemoteRepository({
// //     required this.remoteDataSource,
// //     required this.localDataSource, // Initialize local data source
// //     required this.connectivityService,
// //   });

// //   @override
// //   Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
// //     try {
// //       if (await connectivityService.isConnected()) {
// //         // Has internet, fetch from remote data source
// //         final posts = await remoteDataSource.getAllPosts();
// //         return Right(posts);
// //       } else {
// //         // No internet, fetch from local data source (Hive)
// //         try {
// //           final localPosts = await localDataSource.getAllPosts();
// //           return Right(localPosts);
// //         } catch (localError) {
// //           // Handle local data source error (e.g., Hive not initialized)
// //           return Left(LocalDatabaseFailure(
// //               message: 'Error fetching from local database: $localError'));
// //         }
// //       }
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, void>> createPost(
// //       PostsEntity post, String? token) async {
// //     try {
// //       if (await connectivityService.isConnected()) {
// //         await remoteDataSource.createPost(post, token);
// //         return const Right(null);
// //       } else {
// //         // No internet: save locally (Hive)
// //         try {
// //           await localDataSource.createPost(post, token); // Save to Hive
// //           return const Right(null);
// //         } catch (localError) {
// //           return Left(LocalDatabaseFailure(
// //               message: 'Error saving post locally: $localError'));
// //         }
// //       }
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, void>> deletePost(String postId, String? token) async {
// //     try {
// //       if (await connectivityService.isConnected()) {
// //         await remoteDataSource.deletePost(postId, token);
// //         return const Right(null);
// //       } else {
// //         // No internet: delete locally (Hive)
// //         try {
// //           await localDataSource.deletePost(postId, token); // Delete from Hive
// //           return const Right(null);
// //         } catch (localError) {
// //           return Left(LocalDatabaseFailure(
// //               message: 'Error deleting post locally: $localError'));
// //         }
// //       }
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, String>> uploadImage(File file) async {
// //     // Decide how to handle image uploads offline.  Options:
// //     // 1. Return an error (not supported offline).
// //     // 2. Store the image locally and upload later (more complex).
// //     if (await connectivityService.isConnected()) {
// //       try {
// //         final imageName = await remoteDataSource.uploadImage(file);
// //         return Right(imageName);
// //       } catch (e) {
// //         return Left(ApiFailure(message: e.toString()));
// //       }
// //     } else {
// //       return Left(
// //           ApiFailure(message: 'Image upload not supported in offline mode.'));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
// //     try {
// //       if (await connectivityService.isConnected()) {
// //         final post = await remoteDataSource.getPostById(postId);
// //         return Right(post);
// //       } else {
// //         // No internet: fetch from local data source (Hive)
// //         // Assuming localDataSource.getPostById is implemented
// //         try {
// //           final localPost = await localDataSource.getPostById(postId);
// //           return Right(localPost);
// //         } catch (localError) {
// //           return Left(LocalDatabaseFailure(
// //               message: 'Error fetching post locally: $localError'));
// //         }
// //       }
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, void>> updatePost(
// //       String postId, PostsEntity post, String? token) async {
// //     try {
// //       if (await connectivityService.isConnected()) {
// //         await remoteDataSource.updatePost(postId, post, token);
// //         return const Right(null);
// //       } else {
// //         // No internet: update locally (Hive)
// //         // Assuming localDataSource.updatePost is implemented
// //         try {
// //           await localDataSource.updatePost(postId, post, token);
// //           return const Right(null);
// //         } catch (localError) {
// //           return Left(LocalDatabaseFailure(
// //               message: 'Error updating post locally: $localError'));
// //         }
// //       }
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }
// // }

// // import 'dart:io';

// // import 'package:dartz/dartz.dart';
// // import 'package:koselie/core/error/failure.dart';
// // import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart';
// // import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
// // import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// // import 'package:koselie/features/posts/domain/repository/posts_repository.dart';
// // import 'package:koselie/features/posts/service/connectivity_service.dart';

// // class PostsRemoteRepository implements IPostsRepository {
// //   final PostsRemoteDataSource remoteDataSource;
// //   final PostsLocalDataSource localDataSource;
// //   final ConnectivityService connectivityService;

// //   PostsRemoteRepository({
// //     required this.remoteDataSource,
// //     required this.localDataSource,
// //     required this.connectivityService,
// //   });

// //   @override
// //   Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
// //     bool isOnline = await connectivityService.isConnected();
// //     print("🌍 Network Status: $isOnline");

// //     if (isOnline) {
// //       try {
// //         final posts = await remoteDataSource.getAllPosts();
// //         print("✅ API Returned ${posts.length} posts.");

// //         if (posts.isNotEmpty) {
// //           await localDataSource.cachePosts(posts); // ✅ Store in Hive
// //           print("📂 Posts stored in Hive.");
// //         } else {
// //           print("⚠ No posts received from API, not storing in Hive.");
// //         }

// //         return Right(posts);
// //       } catch (e) {
// //         print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
// //       }
// //     }

// //     // ✅ If offline or API fails, load from Hive
// //     try {
// //       final localPosts = await localDataSource.getAllPosts();
// //       print("📂 Hive Loaded ${localPosts.length} posts.");
// //       return Right(localPosts);
// //     } catch (e) {
// //       return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, void>> createPost(
// //       PostsEntity post, String? token) async {
// //     bool isOnline = await connectivityService.isConnected();
// //     print("🌍 Network Status: $isOnline");

// //     try {
// //       if (isOnline) {
// //         await remoteDataSource.createPost(post, token);
// //         print("✅ Post created via API.");
// //       } else {
// //         await localDataSource.createPost(post, token); // ✅ Save offline
// //         print("📂 Post saved locally in Hive.");
// //       }
// //       return const Right(null);
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, void>> deletePost(String postId, String? token) async {
// //     bool isOnline = await connectivityService.isConnected();
// //     print("🌍 Network Status: $isOnline");

// //     try {
// //       if (isOnline) {
// //         await remoteDataSource.deletePost(postId, token);
// //         print("✅ Post deleted via API.");
// //       } else {
// //         await localDataSource.deletePost(postId, token); // ✅ Delete offline
// //         print("📂 Post deleted from Hive.");
// //       }
// //       return const Right(null);
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, String>> uploadImage(File file) async {
// //     bool isOnline = await connectivityService.isConnected();
// //     print("🌍 Network Status: $isOnline");

// //     if (isOnline) {
// //       try {
// //         final imageName = await remoteDataSource.uploadImage(file);
// //         print("✅ Image uploaded: $imageName");
// //         return Right(imageName);
// //       } catch (e) {
// //         return Left(ApiFailure(message: e.toString()));
// //       }
// //     } else {
// //       print("⚠ Image upload not supported in offline mode.");
// //       return Left(ApiFailure(message: 'Image upload not supported offline.'));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
// //     bool isOnline = await connectivityService.isConnected();
// //     print("🌍 Network Status: $isOnline");

// //     if (isOnline) {
// //       try {
// //         final post = await remoteDataSource.getPostById(postId);
// //         print("✅ Post fetched from API: ${post.postId}");

// //         // await localDataSource.cachePost(post); // ✅ Cache in Hive
// //         print("📂 Post stored in Hive.");

// //         return Right(post);
// //       } catch (e) {
// //         print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
// //       }
// //     }

// //     // ✅ If offline or API fails, load from Hive
// //     try {
// //       final localPost = await localDataSource.getPostById(postId);
// //       print("📂 Hive Loaded Post: ${localPost.postId}");
// //       return Right(localPost);
// //     } catch (e) {
// //       return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, void>> updatePost(
// //       String postId, PostsEntity post, String? token) async {
// //     bool isOnline = await connectivityService.isConnected();
// //     print("🌍 Network Status: $isOnline");

// //     try {
// //       if (isOnline) {
// //         await remoteDataSource.updatePost(postId, post, token);
// //         print("✅ Post updated via API.");
// //       } else {
// //         await localDataSource.updatePost(
// //             postId, post, token); // ✅ Update offline
// //         print("📂 Post updated locally in Hive.");
// //       }
// //       return const Right(null);
// //     } catch (e) {
// //       return Left(ApiFailure(message: e.toString()));
// //     }
// //   }
// // }

// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
// import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart';
// import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/domain/repository/posts_repository.dart';
// import 'package:koselie/features/posts/service/connectivity_service.dart';

// class PostsRemoteRepository implements IPostsRepository {
//   final PostsRemoteDataSource remoteDataSource;
//   final PostsLocalDataSource localDataSource;
//   final ConnectivityService connectivityService;

//   PostsRemoteRepository({
//     required this.remoteDataSource,
//     required this.localDataSource,
//     required this.connectivityService,
//   });

//   // Helper method to check connectivity and log status
//   Future<bool> _checkConnectivity() async {
//     bool isOnline = await connectivityService.isConnected();
//     print("🌍 Network Status: $isOnline");
//     return isOnline;
//   }

//   @override
//   Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
//     final isOnline = await _checkConnectivity();

//     if (isOnline) {
//       try {
//         final posts = await remoteDataSource.getAllPosts();
//         print("✅ API Returned ${posts.length} posts.");

//         if (posts.isNotEmpty) {
//           await localDataSource.cachePosts(posts); // Cache in Hive
//           print("📂 Posts stored in Hive.");
//         } else {
//           print("⚠ No posts received from API, not storing in Hive.");
//         }

//         return Right(posts);
//       } catch (e) {
//         print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
//       }
//     }

//     // Fallback to local data
//     try {
//       final localPosts = await localDataSource.getAllPosts();
//       print("📂 Hive Loaded ${localPosts.length} posts.");
//       return Right(localPosts);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> createPost(
//       PostsEntity post, String? token) async {
//     final isOnline = await _checkConnectivity();

//     try {
//       if (isOnline) {
//         await remoteDataSource.createPost(post, token);
//         print("✅ Post created via API.");
//       } else {
//         await localDataSource.createPost(post, token); // Save offline
//         print("📂 Post saved locally in Hive.");
//       }
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deletePost(String postId, String? token) async {
//     final isOnline = await _checkConnectivity();

//     try {
//       if (isOnline) {
//         await remoteDataSource.deletePost(postId, token);
//         print("✅ Post deleted via API.");
//       } else {
//         await localDataSource.deletePost(postId, token); // Delete offline
//         print("📂 Post deleted from Hive.");
//       }
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadImage(File file) async {
//     final isOnline = await _checkConnectivity();

//     if (isOnline) {
//       try {
//         final imageName = await remoteDataSource.uploadImage(file);
//         print("✅ Image uploaded: $imageName");
//         return Right(imageName);
//       } catch (e) {
//         return Left(ApiFailure(message: e.toString()));
//       }
//     } else {
//       print("⚠ Image upload not supported in offline mode.");
//       return Left(ApiFailure(message: 'Image upload not supported offline.'));
//     }
//   }

//   @override
//   Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
//     final isOnline = await _checkConnectivity();

//     if (isOnline) {
//       try {
//         final post = await remoteDataSource.getPostById(postId);
//         print("✅ Post fetched from API: ${post.postId}");

//         // await localDataSource.cachePost(post); // Cache in Hive
//         print("📂 Post stored in Hive.");

//         return Right(post);
//       } catch (e) {
//         print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
//       }
//     }

//     // Fallback to local data
//     try {
//       final localPost = await localDataSource.getPostById(postId);
//       print("📂 Hive Loaded Post: ${localPost.postId}");
//       return Right(localPost);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> updatePost(
//       String postId, PostsEntity post, String? token) async {
//     final isOnline = await _checkConnectivity();

//     try {
//       if (isOnline) {
//         await remoteDataSource.updatePost(postId, post, token);
//         print("✅ Post updated via API.");
//       } else {
//         await localDataSource.updatePost(postId, post, token); // Update offline
//         print("📂 Post updated locally in Hive.");
//       }
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, CommentEntity>> addComment(String postId, String commentText, String? token) {
//     // TODO: implement addComment
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, List<CommentEntity>>> getComments(String postId) {
//     // TODO: implement getComments
//     throw UnimplementedError();
//   }
// }

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart';
import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';
import 'package:koselie/features/posts/service/connectivity_service.dart';

class PostsRemoteRepository implements IPostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  PostsRemoteRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivityService,
  });

  // Helper method to check connectivity and log status
  Future<bool> _checkConnectivity() async {
    bool isOnline = await connectivityService.isConnected();
    print("🌍 Network Status: $isOnline");
    return isOnline;
  }

  @override
  Future<Either<Failure, CommentEntity>> addComment(
      String postId, String commentText, String? token) async {
    final isOnline = await _checkConnectivity();

    try {
      if (isOnline) {
        final comment =
            await remoteDataSource.addComment(postId, commentText, token);
        print("✅ Comment added via API: ${comment.text}");
        return Right(comment);
      } else {
        return Left(ApiFailure(message: "⚠ Cannot add comments offline."));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<CommentEntity>>> getComments(
  //     String postId, String? token) async {
  //   final isOnline = await _checkConnectivity();

  //   try {
  //     if (isOnline) {
  //       final comments = await remoteDataSource.getComments(postId, null);
  //       print("✅ Fetched ${comments.length} comments from API.");
  //       return Right(comments);
  //     } else {
  //       return Left(ApiFailure(message: "⚠ Cannot fetch comments offline."));
  //     }
  //   } catch (e) {
  //     return Left(ApiFailure(message: e.toString()));
  //   }

  // }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      String postId, String? token) async {
    final isOnline = await _checkConnectivity();

    try {
      if (isOnline) {
        print(
            "🌍 Fetching comments for post: $postId with token: $token"); // ✅ Debug

        if (token == null || token.isEmpty) {
          print("❌ Error: No token provided!");
          return Left(ApiFailure(message: "No token provided!"));
        }

        final comments = await remoteDataSource.getComments(
            postId, token); // ✅ Pass token correctly
        print("✅ Fetched ${comments.length} comments from API.");
        return Right(comments);
      } else {
        return Left(ApiFailure(message: "⚠ Cannot fetch comments offline."));
      }
    } catch (e) {
      print("❌ API Fetch Error: $e");
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
    final isOnline = await _checkConnectivity();

    if (isOnline) {
      try {
        final posts = await remoteDataSource.getAllPosts();
        print("✅ API Returned ${posts.length} posts.");

        if (posts.isNotEmpty) {
          await localDataSource.cachePosts(posts);
          print("📂 Posts stored in Hive.");
        }

        return Right(posts);
      } catch (e) {
        print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
      }
    }

    try {
      final localPosts = await localDataSource.getAllPosts();
      print("📂 Hive Loaded ${localPosts.length} posts.");
      return Right(localPosts);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> createPost(
      PostsEntity post, String? token) async {
    final isOnline = await _checkConnectivity();

    try {
      if (isOnline) {
        await remoteDataSource.createPost(post, token);
        print("✅ Post created via API.");
      } else {
        await localDataSource.createPost(post, token);
        print("📂 Post saved locally in Hive.");
      }
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId, String? token) async {
    final isOnline = await _checkConnectivity();

    try {
      if (isOnline) {
        await remoteDataSource.deletePost(postId, token);
        print("✅ Post deleted via API.");
      } else {
        await localDataSource.deletePost(postId, token);
        print("📂 Post deleted from Hive.");
      }
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) async {
    final isOnline = await _checkConnectivity();

    if (isOnline) {
      try {
        final imageName = await remoteDataSource.uploadImage(file);
        print("✅ Image uploaded: $imageName");
        return Right(imageName);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return Left(ApiFailure(message: '⚠ Image upload not supported offline.'));
    }
  }

  @override
  Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
    final isOnline = await _checkConnectivity();

    if (isOnline) {
      try {
        final post = await remoteDataSource.getPostById(postId);
        print("✅ Post fetched from API: ${post.postId}");
        return Right(post);
      } catch (e) {
        print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
      }
    }

    try {
      final localPost = await localDataSource.getPostById(postId);
      print("📂 Hive Loaded Post: ${localPost.postId}");
      return Right(localPost);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(
      String postId, PostsEntity post, String? token) async {
    final isOnline = await _checkConnectivity();

    try {
      if (isOnline) {
        await remoteDataSource.updatePost(postId, post, token);
        print("✅ Post updated via API.");
      } else {
        await localDataSource.updatePost(postId, post, token);
        print("📂 Post updated locally in Hive.");
      }
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
