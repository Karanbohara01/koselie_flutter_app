import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class UpdateUserUseCase implements UsecaseWithParams<void, AuthEntity> {
  final IAuthRepository _repository;

  UpdateUserUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AuthEntity entity) {
    return _repository.updateUser(entity);
  }
}
