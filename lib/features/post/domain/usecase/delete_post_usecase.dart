import 'package:dartz/dartz.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/post/domain/repository/post_repository.dart';

class DeletePostUsecase implements UsecaseWithParams<void, String> {
  // Params is String (postId)
  final IPostRepository postRepository;

  DeletePostUsecase({required this.postRepository});

  @override
  Future<Either<Failure, void>> call(String postId) async {
    return await postRepository.deletePost(postId);
  }
}
