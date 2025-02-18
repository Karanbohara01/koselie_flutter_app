// import 'package:dartz/dartz.dart';
// import 'package:koselie/app/usecase/usecase.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

// class UpdateUserUseCase implements UsecaseWithParams<void, AuthEntity> {
//   final IAuthRepository _repository;

//   UpdateUserUseCase(this._repository);

//   @override
//   Future<Either<Failure, void>> call(AuthEntity entity) {
//     return _repository.updateUser(entity);
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class UpdateUserParams extends Equatable {
  final AuthEntity entity;

  const UpdateUserParams({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class UpdateUserUsecase implements UsecaseWithParams<void, UpdateUserParams> {
  final IAuthRepository authRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdateUserUsecase(
    IAuthRepository iAuthRepository, {
    required this.authRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    // Retrieve the token from shared preferences
    final token = await tokenSharedPrefs.getToken();
    return token.fold((failure) {
      return Left(failure);
    }, (token) async {
      // ✅ Use `AuthEntity` for updating user profile
      return await authRepository.updateUser(params.entity, token ?? '');
    });
  }
}
