import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

class UploadPostsImageParams {
  final File file;

  const UploadPostsImageParams({
    required this.file,
  });
}

class UploadPostsImageUsecase
    implements UsecaseWithParams<String, UploadPostsImageParams> {
  final IPostsRepository _repository;

  UploadPostsImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadPostsImageParams params) {
    return _repository.uploadImage(params.file);
  }
}
