import 'package:koselie/core/network/hive_service.dart';
import 'package:koselie/features/category/data/data_source/category_data_source.dart';
import 'package:koselie/features/category/data/model/category_hive_model.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';

class CategoryLocalDataSource implements ICategoryDataSource {
  final HiveService hiveService;

  CategoryLocalDataSource({required this.hiveService});

  @override
  Future<void> createCategory(CategoryEntity category) async {
    try {
      // Convert BatchEntity to BatchHiveModel
      final categoryHiveModel = CategoryHiveModel.fromEntity(category);
      await hiveService.createCategory(categoryHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCategory(String categoryId, String? token) async {
    try {
      await hiveService.deleteCategory(categoryId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() {
    try {
      return hiveService.getAllCategories().then(
        (value) {
          return value.map((e) => e.toEntity()).toList();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
