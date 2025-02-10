import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';
import 'package:koselie/features/post/domain/repository/post_repository.dart';

class CreatePostParams extends Equatable {
  final String caption;
  final String price;
  final String location;
  final String description;
  final String image;
  final String authorId;
  final List<String> likeIds;
  final List<String> commentIds;
  final List<String> categoryIds;

  const CreatePostParams({
    required this.caption,
    required this.price,
    required this.location,
    required this.description,
    required this.image,
    required this.authorId,
    this.likeIds = const [],
    this.commentIds = const [],
    this.categoryIds = const [],
  });

  //  Create empty constructor
  const CreatePostParams.empty()
      : caption = '',
        price = '',
        location = '',
        description = '',
        image = '',
        authorId = '',
        likeIds = const [],
        commentIds = const [],
        categoryIds = const [];

  @override
  List<Object?> get props => [
        caption,
        price,
        location,
        description,
        image,
        authorId,
        likeIds,
        commentIds,
        categoryIds,
      ];
}

class CreatePostUsecase implements UsecaseWithParams<void, CreatePostParams> {
  final IPostRepository postRepository;
  CreatePostUsecase({required this.postRepository});
  @override
  Future<Either<Failure, void>> call(CreatePostParams params) async {
    return await postRepository.createPost(
      PostEntity(
        caption: params.caption,
        price: params.price,
        description: params.description,
        location: params.location,
        image: params.image,
        authorId: params.authorId,
        likeIds: params.likeIds,
        commentIds: params.commentIds,
        categoryIds: params.categoryIds,
      ),
    );
  }
}
