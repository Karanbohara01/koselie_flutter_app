// Usecase Code
import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class DeleteProfilePictureUseCase implements UsecaseWithoutParams<void> {
  final IAuthRepository _repository;

  DeleteProfilePictureUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call() {
    return _repository.deleteProfilePicture();
  }
}
