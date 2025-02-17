import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
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
  final TokenSharedPrefs tokenSharedPrefs; // ✅ Inject Token Shared Prefs

  CreateCategoryUseCase({
    required this.categoryRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(CreateCategoryParams params) async {
    // ✅ Get token from Shared Preferences
    final tokenResult = await tokenSharedPrefs.getToken();

    return tokenResult.fold(
      (failure) => Left(failure), // ✅ Handle token retrieval failure
      (token) async {
        return await categoryRepository.createCategory(
          CategoryEntity(name: params.name),
          token ?? '', // ✅ Pass token to repository
        );
      },
    );
  }
}
