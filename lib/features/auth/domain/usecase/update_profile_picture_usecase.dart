import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class UpdateProfilePictureUseCase implements UsecaseWithParams<String, File> {
  final IAuthRepository _repository;

  UpdateProfilePictureUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(File file) {
    return _repository.updateProfilePicture(file);
  }
}
