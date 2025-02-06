import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class DeleteUserUseCase implements UsecaseWithParams<void, String> {
  final IAuthRepository _repository;

  DeleteUserUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String userId) {
    return _repository.deleteUser(userId);
  }
}
