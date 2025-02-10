import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';
import 'package:koselie/features/post/domain/repository/post_repository.dart';

class GetAllPostUsecase implements UsecaseWithoutParams<List<PostEntity>> {
  final IPostRepository repository;

  GetAllPostUsecase(this.repository);

  @override
  Future<Either<Failure, List<PostEntity>>> call() {
    return repository.getAllPosts();
  }
}
