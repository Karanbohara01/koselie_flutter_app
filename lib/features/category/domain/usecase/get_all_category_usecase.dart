import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/domain/repository/category_repository.dart';

class GetAllCategoryUseCase
    implements UsecaseWithoutParams<List<CategoryEntity>> {
  final ICategoryRepository categoryRepository;

  GetAllCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return categoryRepository.getAllCategories();
  }
}
