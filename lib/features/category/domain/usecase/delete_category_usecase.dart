import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/domain/repository/category_repository.dart';

class DeleteCategoryParams extends Equatable {
  final String categoryId;

  const DeleteCategoryParams({required this.categoryId});

  const DeleteCategoryParams.empty() : categoryId = '_empty.string';

  @override
  List<Object?> get props => [
        categoryId,
      ];
}

class DeleteCategoryUsecase
    implements UsecaseWithParams<void, DeleteCategoryParams> {
  final ICategoryRepository categoryRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteCategoryUsecase({
    required this.categoryRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteCategoryParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await categoryRepository.deleteCategory(params.categoryId, r);
    });
  }
}
