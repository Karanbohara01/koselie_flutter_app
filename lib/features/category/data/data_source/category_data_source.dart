import 'package:koselie/features/category/domain/entity/category_entity.dart';

abstract interface class ICategoryDataSource {
  Future<List<CategoryEntity>> getAllCategories();
  Future<void> createCategory(CategoryEntity category);
  Future<void> deleteCategory(String categoryId, String? token);
}
