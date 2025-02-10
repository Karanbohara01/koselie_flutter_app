import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/data/data_source/local_datasource/category_local_data_source.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/domain/repository/category_repository.dart';

class CategoryLocalRepository implements ICategoryRepository {
  final CategoryLocalDataSource _categoryLocalDataSource;
  CategoryLocalRepository(
      {required CategoryLocalDataSource categoryLocalDataSource})
      : _categoryLocalDataSource = categoryLocalDataSource;

  @override
  Future<Either<Failure, void>> createCategory(CategoryEntity category) {
    try {
      _categoryLocalDataSource.createCategory(category);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(
      String categoryId, String? token) {
    try {
      _categoryLocalDataSource.deleteCategory(categoryId, token);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    try {
      return _categoryLocalDataSource.getAllCategories().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
