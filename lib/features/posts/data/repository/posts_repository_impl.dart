// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:koselie/core/common/internet_checker/network_info.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/posts/data/data_source/local_datasource/posts_local_data_source.dart';
// import 'package:koselie/features/posts/data/data_source/remote_datasource/posts_remote_data_source.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

// class PostsRepositoryImpl implements IPostsRepository {
//   final NetworkInfo networkInfo;
//   final PostsRemoteDataSource remoteDataSource;
//   final PostsLocalDataSource localDataSource;

//   PostsRepositoryImpl({
//     required this.networkInfo,
//     required this.remoteDataSource,
//     required this.localDataSource,
//   });

//   @override
//   Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
//     if (await networkInfo.isConnected) {
//       print("🟢 Internet Available: Fetching from Remote API...");
//       try {
//         final posts = await remoteDataSource.getAllPosts();
//         await localDataSource.cachePosts(posts); // Cache data locally
//         print("✅ Data Cached in Hive: ${posts.length} posts stored.");
//         return Right(posts);
//       } catch (e) {
//         print("❌ API Fetch Error: $e");
//         return Left(ApiFailure(message: "Failed to fetch posts: $e"));
//       }
//     } else {
//       print("🔴 No Internet: Fetching from Local Storage...");
//       try {
//         final cachedPosts = await localDataSource.getAllPosts();
//         print("✅ Retrieved from Cache: ${cachedPosts.length} posts found.");
//         return Right(cachedPosts);
//       } catch (e) {
//         print("❌ No Cached Data Found.");
//         return Left(LocalDatabaseFailure(
//             message: "No internet & no cached data found!"));
//       }
//     }
//   }

//   @override
//   Future<Either<Failure, void>> createPost(
//       PostsEntity post, String? token) async {
//     if (await networkInfo.isConnected) {
//       print("🟢 Internet Available: Sending post to Remote API...");
//       try {
//         await remoteDataSource.createPost(post, token); // Send to API
//         await localDataSource.createPost(post, token); // Cache locally
//         print("✅ Post successfully created & cached!");
//         return const Right(null);
//       } catch (e) {
//         print("❌ API Create Post Error: $e");
//         return Left(ApiFailure(message: "Failed to create post: $e"));
//       }
//     } else
//       print("🔴 No Internet: Storing post in Local Storage...");
//       try {
//         await localDataSource.createPost(post, token); // Save locally
//         print("✅ Post saved in Hive (offline mode).");
//         return const Right(null);
//       } catch (e) {
//         print("❌ Local Storage Error: $e");
//         return Left(
//             LocalDatabaseFailure(message: "Failed to save post locally: $e"));
//       }
//     }
//   }

//   @override
//   Future<Either<Failure, PostsEntity>> getPostById(String postId) async {
//     if (await networkInfo.isConnected) {
//       print("🟢 Internet Available: Fetching Post from API...");
//       try {
//         final post = await remoteDataSource.getPostById(postId);
//         return Right(post);
//       } catch (e) {
//         print("❌ API Fetch Post Error: $e");
//         return Left(ApiFailure(message: "Failed to fetch post: $e"));
//       }
//     } else {
//       print("🔴 No Internet: Fetching Post from Local Storage...");
//       try {
//         final post = await localDataSource.getPostById(postId);
//         return Right(post);
//       } catch (e) {
//         print("❌ Local Fetch Post Error: $e");
//         return Left(LocalDatabaseFailure(message: "Post not found offline!"));
//       }
//     }
//   }

//   @override
//   Future<Either<Failure, void>> updatePost(
//       String postId, PostsEntity post, String? token) async {
//     if (await networkInfo.isConnected) {
//       print("🟢 Internet Available: Updating post in API...");
//       try {
//         await remoteDataSource.updatePost(postId, post, token); // Update API
//         await localDataSource.updatePost(postId, post, token); // Update Local
//         print("✅ Post updated in API & Hive.");
//         return const Right(null);
//       } catch (e) {
//         print("❌ API Update Error: $e");
//         return Left(ApiFailure(message: "Failed to update post: $e"));
//       }
//     } else {
//       print("🔴 No Internet: Cannot Update Post.");
//       return Left(ApiFailure(message: "No internet connection."));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadImage(File file) async {
//     if (await networkInfo.isConnected) {
//       print("🟢 Internet Available: Uploading Image...");
//       try {
//         final imageUrl = await remoteDataSource.uploadImage(file);
//         print("✅ Image Uploaded: $imageUrl");
//         return Right(imageUrl);
//       } catch (e) {
//         print("❌ Image Upload Error: $e");
//         return Left(ApiFailure(message: "Failed to upload image: $e"));
//       }
//     } else {
//       print("🔴 No Internet: Cannot Upload Image.");
//       return Left(ApiFailure(message: "No internet connection."));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deletePost(String postId, String? token) async {
//     if (await networkInfo.isConnected) {
//       print("🟢 Internet Available: Deleting post from API...");
//       try {
//         await remoteDataSource.deletePost(postId, token); // Delete from API
//         await localDataSource.deletePost(postId, token); // Delete from Local
//         print("✅ Post deleted from API & Hive.");
//         return const Right(null);
//       } catch (e) {
//         print("❌ API Delete Error: $e");
//         return Left(ApiFailure(message: "Failed to delete post: $e"));
//       }
//     } else {
//       print("🔴 No Internet: Cannot Delete Post.");
//       return Left(ApiFailure(message: "No internet connection."));
//     }
//   }
// }
