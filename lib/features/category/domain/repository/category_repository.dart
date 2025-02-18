import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, void>> createCategory(
      CategoryEntity category, String token);
  Future<Either<Failure, void>> deleteCategory(
      String categoryId, String? token);
}
