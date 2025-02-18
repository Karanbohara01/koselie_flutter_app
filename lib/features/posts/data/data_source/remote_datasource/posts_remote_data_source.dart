import 'dart:io';

import 'package:dio/dio.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/posts/data/data_source/posts_data_source.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

class PostsRemoteDataSource implements IPostsDataSource {
  final Dio _dio;

  PostsRemoteDataSource(this._dio);

  @override
  Future<void> createPost(PostsEntity post) async {
    try {
      Response response = await _dio.post(ApiEndpoints.createPost, data: {
        "caption": post.caption,
        "location": post.location,
        "image": post.image,
        "price": post.price,
        "description": post.description,
        "category": post.category.categoryId
      });
      if (response.statusCode == 200) {
        return;
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
  Future<void> deletePost(String postId, String? token) {
    // TODO: implement deletePost
    throw UnimplementedError();
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
}
