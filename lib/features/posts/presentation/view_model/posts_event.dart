// part of 'posts_bloc.dart';

// sealed class PostsEvent extends Equatable {
//   const PostsEvent();

//   @override
//   List<Object> get props => [];
// }

// final class LoadCategories extends PostsEvent {}

// class UploadPostsImage extends PostsEvent {
//   final File file;

//   const UploadPostsImage({
//     required this.file,
//   });
// }

// class LoadPosts extends PostsEvent {
//   final BuildContext context;

//   const LoadPosts({required this.context});
// }

// final class CreatePost extends PostsEvent {
//   const CreatePost({
//     required this.context, // Context added here
//     required this.caption,
//     required this.location,
//     required this.price,
//     required this.category,
//     required this.description,
//     this.image,
//   });

//   final BuildContext
//       context; // Context to use in showing snackbar or other UI operations
//   final String caption;
//   final String location;
//   final String price;
//   final CategoryEntity category;
//   final String? image;
//   final String description;
// }

part of 'posts_bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

/// ✅ Event to Load Categories
final class LoadCategories extends PostsEvent {}

/// ✅ Event to Upload an Image for a Post
class UploadPostsImage extends PostsEvent {
  final File file;

  const UploadPostsImage({required this.file});

  @override
  List<Object> get props => [file];
}

/// ✅ Event to Load All Posts
class LoadPosts extends PostsEvent {
  final BuildContext context;

  const LoadPosts({required this.context});

  @override
  List<Object> get props => [context];
}

/// ✅ Event to Create a New Post
final class CreatePost extends PostsEvent {
  final BuildContext context;
  final String caption;
  final String location;
  final String price;
  final CategoryEntity category;
  final String? image;
  final String description;

  const CreatePost({
    required this.context,
    required this.caption,
    required this.location,
    required this.price,
    required this.category,
    required this.description,
    this.image,
  });

  @override
  List<Object?> get props => [
        context,
        caption,
        location,
        price,
        category,
        description,
        image,
      ];
}

/// ✅ Event to Fetch a Single Post by ID
final class GetPostById extends PostsEvent {
  final String postId;
  final BuildContext context;

  const GetPostById({required this.postId, required this.context});

  @override
  List<Object> get props => [postId, context];
}
