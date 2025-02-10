import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/domain/repository/category_repository.dart';

class CreateCategoryParams extends Equatable {
  final String name;

  const CreateCategoryParams({required this.name});

  // Empty constructor
  const CreateCategoryParams.empty() : name = '_empty.string';

  @override
  List<Object?> get props => [name];
}

class CreateCategoryUseCase
    implements UsecaseWithParams<void, CreateCategoryParams> {
  final ICategoryRepository categoryRepository;

  CreateCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, void>> call(CreateCategoryParams params) async {
    return await categoryRepository.createCategory(
      CategoryEntity(
        name: params.name,
      ),
    );
  }
}
