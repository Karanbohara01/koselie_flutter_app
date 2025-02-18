import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

class GetAllPostsUseCase implements UsecaseWithoutParams<List<PostsEntity>> {
  final IPostsRepository postRepository;

  GetAllPostsUseCase({required this.postRepository});

  @override
  Future<Either<Failure, List<PostsEntity>>> call() {
    return postRepository.getAllPosts();
  }
}
