// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/repository/posts_repository.dart';

class CreatePostsParams extends Equatable {
  final String caption;
  final String location;
  final String description;
  final String price;
  final String? image;
  final CategoryEntity category;

  // Standard constructor
  const CreatePostsParams({
    required this.caption,
    required this.location,
    required this.description,
    required this.price,
    required this.category,
    this.image,
  });

  // Empty constructor with default values
  const CreatePostsParams.empty()
      : caption = '',
        location = '',
        description = '',
        price = '',
        image = null,
        category = const CategoryEntity.empty();

  @override
  List<Object?> get props =>
      [caption, location, description, price, image, category];
}

class CreatePostsUseCase implements UsecaseWithParams<void, CreatePostsParams> {
  final IPostsRepository postsRepository;
  final TokenSharedPrefs tokenSharedPrefs; // ✅ Inject TokenSharedPrefs

  CreatePostsUseCase({
    required this.postsRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(CreatePostsParams params) async {
    // ✅ Retrieve token from Shared Preferences
    final tokenResult = await tokenSharedPrefs.getToken();

    return tokenResult.fold(
      (failure) => Left(failure), // ✅ Handle token retrieval failure
      (token) async {
        if (token == null || token.isEmpty) {
          return Left(AuthFailure('Authentication token is missing.'));
        }

        try {
          final postEntity = PostsEntity(
            caption: params.caption,
            description: params.description,
            price: params.price,
            location: params.location,
            image: params.image ?? '', // Default empty string if image is null
            category: params.category,
          );

          return await postsRepository.createPost(postEntity, token);
        } catch (e) {
          return Left(ServerFailure('Failed to create post: $e'));
        }
      },
    );
  }
}
