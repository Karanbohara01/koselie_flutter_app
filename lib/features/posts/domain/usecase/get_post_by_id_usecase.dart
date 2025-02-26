// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

/// ✅ Defines the parameter for getting a post by ID
class GetPostByIdParams extends Equatable {
  final String postId;

  const GetPostByIdParams({required this.postId});

  @override
  List<Object> get props => [postId];
}

/// ✅ Implements the use case to fetch a single post by ID
class GetPostByIdUseCase
    implements UsecaseWithParams<PostsEntity, GetPostByIdParams> {
  final IPostsRepository postsRepository;

  GetPostByIdUseCase({required this.postsRepository});

  @override
  Future<Either<Failure, PostsEntity>> call(GetPostByIdParams params) async {
    return await postsRepository.getPostById(params.postId);
  }
}
