part of 'posts_bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

final class LoadCategories extends PostsEvent {}

class UploadPostsImage extends PostsEvent {
  final File file;

  const UploadPostsImage({
    required this.file,
  });
}

class LoadPosts extends PostsEvent {
  final BuildContext context;

  const LoadPosts({required this.context});
}

final class CreatePost extends PostsEvent {
  const CreatePost({
    required this.context, // Context added here
    required this.caption,
    required this.location,
    required this.price,
    required this.category,
    required this.description,
    this.image,
  });

  final BuildContext
      context; // Context to use in showing snackbar or other UI operations
  final String caption;
  final String location;
  final String price;
  final CategoryEntity category;
  final String? image;
  final String description;
}
