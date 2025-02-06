import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class GetUserByIdUseCase implements UsecaseWithParams<AuthEntity, String> {
  final IAuthRepository _repository;

  GetUserByIdUseCase(this._repository);

  @override
  Future<Either<Failure, AuthEntity>> call(String userId) {
    return _repository.getUserById(userId);
  }
}
