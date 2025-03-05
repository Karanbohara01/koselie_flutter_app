import 'dart:io';

import 'package:dio/dio.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/data/data_source/posts_data_source.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

class PostsRemoteDataSource implements IPostsDataSource {
  final Dio _dio;

  PostsRemoteDataSource(this._dio);

  @override
  Future<void> createPost(PostsEntity post, String? token) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.createPost,
        data: {
          "caption": post.caption,
          "location": post.location,
          "image": post.image,
          "price": post.price,
          "description": post.description,
          "category": post.category.categoryId
        },
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // ✅ Added Authorization Token
        }),
      );

      if (response.statusCode != 201) {
        throw ServerFailure('Failed to create post',
            statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      throw ServerFailure('Dio Error: ${e.response?.data ?? e.message}',
          statusCode: e.response?.statusCode);
    } catch (e) {
      throw ServerFailure('Error: ${e.toString()}');
    }
  }

  @override
  Future<void> deletePost(String postId, String? token) async {
    try {
      Response response = await _dio.delete(
        "${ApiEndpoints.deletePost}/delete/$postId", // Add "/delete/" before ID
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Successfully deleted
        return;
      } else {
        throw ServerFailure('Failed to delete post',
            statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      throw ServerFailure('Dio Error: ${e.response?.data ?? e.message}',
          statusCode: e.response?.statusCode);
    } catch (e) {
      throw ServerFailure('Error: ${e.toString()}');
    }
  }

  @override
  Future<List<PostsEntity>> getAllPosts() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getAllPosts);

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        // Check if responseData is a Map and contains both 'data' and 'posts' keys
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('posts')) {
          List<dynamic> postsData =
              responseData['posts']; // Access the list of posts

          // Ensure that postsData is a List before mapping
          return postsData
              .map((post) => PostsEntity.fromJson(post as Map<String, dynamic>))
              .toList();
        } else {
          // Handle the case where responseData is not a Map or doesn't contain 'posts' key
          print(
              "Warning: response.data is not a Map or does not contain 'posts'. Returning an empty list.");
          return <PostsEntity>[]; // Return an empty list
        }
      } else if (response.statusCode == 404) {
        // Handle the case where no posts are found (404 status code)
        print("No posts found (404). Returning an empty list.");
        return <PostsEntity>[]; // Return an empty list
      } else {
        // Handle other error status codes
        print(
            "Error: Received status code ${response.statusCode}. Returning an empty list.");
        return <PostsEntity>[]; // Return an empty list
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      print("DioException: ${e.message}. Returning an empty list.");
      return <PostsEntity>[]; // Return an empty list
    } catch (e) {
      // Handle any other exceptions
      print("Exception: ${e.toString()}. Returning an empty list.");
      return <PostsEntity>[]; // Return an empty list
    }
  }

  @override
  Future<String> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          )
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadPostsImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PostsEntity> getPostById(String postId) async {
    try {
      Response response = await _dio.get("${ApiEndpoints.getPostById}/$postId");

      print("📩 Response Status Code: ${response.statusCode}");
      print("📩 Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data.containsKey('post')) {
          final postJson = data['post'];

          return PostsEntity.fromJson({
            ...postJson,
            'category': (postJson['category'] is List &&
                    postJson['category'].isNotEmpty)
                ? postJson['category'].first
                : {},
          });
        } else {
          throw Exception("Invalid response format: 'post' key missing");
        }
      } else {
        throw Exception("Failed to fetch post: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.response?.data ?? e.message}");
      throw Exception("DioError: ${e.message}");
    } catch (e) {
      print("❌ General Error: ${e.toString()}");
      throw Exception("Error: ${e.toString()}");
    }
  }

  @override
  Future<void> updatePost(
      String postId, PostsEntity post, String? token) async {
    try {
      Response response = await _dio.put(
        "${ApiEndpoints.updatePost}/$postId", // Update post API endpoint
        data: {
          "caption": post.caption,
          "location": post.location,
          "image": post.image,
          "price": post.price,
          "description": post.description,
          "category": post.category.categoryId,
        },
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // ✅ Added Authorization Token
        }),
      );

      if (response.statusCode != 200) {
        throw ServerFailure('Failed to update post',
            statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      throw ServerFailure('Dio Error: ${e.response?.data ?? e.message}',
          statusCode: e.response?.statusCode);
    } catch (e) {
      throw ServerFailure('Error: ${e.toString()}');
    }
  }

  @override
  Future<CommentEntity> addComment(
      String postId, String commentText, String? token) async {
    try {
      Response response = await _dio.post(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.addComment(postId)}", // ✅ Using ApiEndpoints pattern
        data: {"text": commentText},
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null)
            'Authorization': 'Bearer $token', // ✅ Ensuring token consistency
        }),
      );

      if (response.statusCode == 201) {
        final data = response.data;
        if (data.containsKey('comment')) {
          return CommentEntity.fromJson(data['comment']);
        } else {
          throw ServerFailure("Invalid response: Missing 'comment' key");
        }
      } else {
        throw ServerFailure("Failed to add comment",
            statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      throw ServerFailure("DioError: ${e.response?.data ?? e.message}",
          statusCode: e.response?.statusCode);
    } catch (e) {
      throw ServerFailure("Error: ${e.toString()}");
    }
  }
// working
  // @override
  // Future<List<CommentEntity>> getComments(String postId, String? token) async {

  //   try {
  //     final headers = {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       if (token != null) 'Authorization': 'Bearer $token',
  //     };

  //     final response = await _dio.get(
  //       'http://192.168.1.100:8000/api/v1/post/$postId/comment/all',
  //     );

  //     print("📩 Response Status: ${response.statusCode}");
  //     print("📩 Response Data: ${response.data}");

  //     if (response.statusCode == 200) {
  //       final data = response.data;

  //       if (data is Map<String, dynamic> &&
  //           data.containsKey('comments') &&
  //           data['comments'] is List) {
  //         List<dynamic> commentsData = data['comments'];
  //         print("✅ Comments Retrieved: ${commentsData.length}");

  //         return commentsData
  //             .map((comment) =>
  //                 CommentEntity.fromJson(comment as Map<String, dynamic>))
  //             .toList();
  //       } else {
  //         throw ServerFailure(
  //             "Invalid response: 'comments' key missing or not a list");
  //       }
  //     } else {
  //       throw ServerFailure(
  //           "Failed to fetch comments: ${response.statusMessage}",
  //           statusCode: response.statusCode);
  //     }
  //   } on DioException catch (e) {
  //     print("❌ DioError Type: ${e.type}");
  //     print("❌ DioError Message: ${e.message}");
  //     if (e.response != null) {
  //       print("❌ DioError Response: ${e.response!.data}");
  //       print("❌ Status Code: ${e.response!.statusCode}");
  //     }
  //     throw ServerFailure("DioError: ${e.response?.data ?? e.message}",
  //         statusCode: e.response?.statusCode);
  //   } catch (e) {
  //     print("❌ General Error: ${e.toString()}");
  //     throw ServerFailure("Error: ${e.toString()}");
  //   }
  // }

  @override
  Future<List<CommentEntity>> getComments(String postId, String? token) async {
    try {
      if (token == null || token.isEmpty) {
        throw ServerFailure("❌ Error: No token provided!");
      }

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Ensure the token is added here
      };

      print("🌍 Fetching comments for post ID: $postId");
      print(
          "🔹 Request URL: http://10.0.2.2:8000/api/v1/post/$postId/comment/all");
      print("🔹 Headers: $headers");

      final response = await _dio.get(
        'http://10.0.2.2:8000/api/v1/post/$postId/comment/all',
        options: Options(headers: headers), // Ensure headers are passed
      );

      print("📩 Response Status: ${response.statusCode}");
      print("📩 Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> &&
            data.containsKey('comments') &&
            data['comments'] is List) {
          List<dynamic> commentsData = data['comments'];
          print("✅ Comments Retrieved: ${commentsData.length}");

          return commentsData
              .map((comment) =>
                  CommentEntity.fromJson(comment as Map<String, dynamic>))
              .toList();
        } else {
          throw ServerFailure(
              "Invalid response: 'comments' key missing or not a list");
        }
      } else {
        throw ServerFailure(
            "Failed to fetch comments: ${response.statusMessage}",
            statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      print("❌ DioError Type: ${e.type}");
      print("❌ DioError Message: ${e.message}");

      if (e.response != null) {
        print("❌ DioError Response Data: ${e.response!.data}");
        print("❌ Status Code: ${e.response!.statusCode}");
      }

      throw ServerFailure("DioError: ${e.response?.data ?? e.message}",
          statusCode: e.response?.statusCode);
    } catch (e) {
      print("❌ General Error: ${e.toString()}");
      throw ServerFailure("Error: ${e.toString()}");
    }
  }
}
