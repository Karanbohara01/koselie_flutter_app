// part of 'posts_bloc.dart';

// sealed class PostsEvent extends Equatable {
//   const PostsEvent();

//   @override
//   List<Object?> get props => [];
// }

// /// ✅ Event to Load Categories
// final class LoadCategories extends PostsEvent {}

// /// ✅ Event to Upload an Image for a Post
// class UploadPostsImage extends PostsEvent {
//   final File file;
//   final BuildContext context; // ✅ Added BuildContext

//   const UploadPostsImage({required this.file, required this.context});

//   @override
//   List<Object> get props => [file];
// }

// /// ✅ Event to Load All Posts
// class LoadPosts extends PostsEvent {
//   final BuildContext context; // ✅ Added BuildContext

//   const LoadPosts({required this.context});
// }

// /// ✅ Event to Create a New Post
// final class CreatePost extends PostsEvent {
//   final BuildContext context;
//   final String caption;
//   final String location;
//   final String price;
//   final CategoryEntity category;
//   final String? image;
//   final String description;

//   const CreatePost({
//     required this.context,
//     required this.caption,
//     required this.location,
//     required this.price,
//     required this.category,
//     required this.description,
//     this.image,
//   });

//   @override
//   List<Object?> get props => [
//         context,
//         caption,
//         location,
//         price,
//         category,
//         description,
//         image,
//       ];
// }

// /// ✅ Event to Fetch a Single Post by ID
// final class GetPostById extends PostsEvent {
//   final String postId;
//   final BuildContext context;

//   const GetPostById({required this.postId, required this.context});

//   @override
//   List<Object> get props => [postId, context];
// }

// /// ✅ Event to Delete a Post
// final class DeletePost extends PostsEvent {
//   final String postId;
//   final BuildContext context;

//   const DeletePost({required this.postId, required this.context});

//   @override
//   List<Object> get props => [postId, context];
// }

// /// ✅ Event to Update a Post
// final class UpdatePost extends PostsEvent {
//   final String postId;
//   final PostsEntity post;
//   final BuildContext context;

//   const UpdatePost(
//       {required this.postId, required this.post, required this.context});

//   @override
//   List<Object> get props => [postId, post, context];
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
  final BuildContext context;

  const UploadPostsImage({required this.file, required this.context});

  @override
  List<Object> get props => [file, context];
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

/// ✅ Event to Delete a Post
final class DeletePost extends PostsEvent {
  final String postId;
  final BuildContext context;

  const DeletePost({required this.postId, required this.context});

  @override
  List<Object> get props => [postId, context];
}

/// ✅ Event to Update a Post
final class UpdatePost extends PostsEvent {
  final String postId;
  final PostsEntity post;
  final BuildContext context;

  const UpdatePost(
      {required this.postId, required this.post, required this.context});

  @override
  List<Object> get props => [postId, post, context];
}

/// ✅ Event to Add a Comment to a Post
final class AddComment extends PostsEvent {
  final String postId;
  final String commentText;
  final BuildContext context;

  const AddComment(
      {required this.postId, required this.commentText, required this.context});

  @override
  List<Object> get props => [postId, commentText, context];
}

/// ✅ Event to Fetch Comments for a Post
final class GetComments extends PostsEvent {
  final String postId;
  final BuildContext context;

  const GetComments({required this.postId, required this.context});

  @override
  List<Object> get props => [postId, context];
}
