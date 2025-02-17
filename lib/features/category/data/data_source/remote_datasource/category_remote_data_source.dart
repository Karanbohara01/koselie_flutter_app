import 'package:dio/dio.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/category/data/data_source/category_data_source.dart';
import 'package:koselie/features/category/data/model/category_api_model.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';

class CategoryRemoteDataSource implements ICategoryDataSource {
  final Dio _dio;

  CategoryRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  // @override
  // Future<void> createCategory(CategoryEntity category) async {
  //   try {
  //     // Convert entity to model
  //     var categoryApiModel = CategoryApiModel.fromEntity(category);
  //     var response = await _dio.post(
  //       ApiEndpoints.createCategory,
  //       data: categoryApiModel.toJson(),
  //     );
  //     if (response.statusCode == 201) {
  //       return;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
  Future<void> createCategory(CategoryEntity category, String token) async {
    try {
      // Convert entity to model
      var categoryApiModel = CategoryApiModel.fromEntity(category);

      var response = await _dio.post(
        ApiEndpoints.createCategory,
        data: categoryApiModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // ✅ Added token
          },
        ),
      );

      if (response.statusCode == 201) {
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
  Future<void> deleteCategory(String categoryId, String? token) async {
    try {
      var response = await _dio.delete(
        ApiEndpoints.deleteCategory + categoryId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

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
  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllCategories);
      if (response.statusCode == 200) {
        List<dynamic> categoryList = response.data;
        List<CategoryApiModel> categoryApiModels = categoryList
            .map((categoryJson) => CategoryApiModel.fromJson(categoryJson))
            .toList();
        return CategoryApiModel.toEntityList(categoryApiModels);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print('DioError in getAllCategories: $e');
      throw Exception(e);
    } catch (e) {
      print('Error in getAllCategories: $e');
      throw Exception(e);
    }
  }
}
