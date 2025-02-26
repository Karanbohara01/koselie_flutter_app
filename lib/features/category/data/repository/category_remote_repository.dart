import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/data/data_source/remote_datasource/category_remote_data_source.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/domain/repository/category_repository.dart';

class CategoryRemoteRepository implements ICategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createCategory(
      CategoryEntity category, String token) async {
    try {
      await remoteDataSource.createCategory(category, token); // ✅ Pass token
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(
      String categoryId, String? token) async {
    try {
      await remoteDataSource.deleteCategory(categoryId, token);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final categories = await remoteDataSource.getAllCategories();
      return Right(categories);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
