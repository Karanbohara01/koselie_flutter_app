// part of 'posts_bloc.dart';

// class PostsState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final String? imageName;
//   final List<PostsEntity> posts; // Added list of posts
//   final String? error; // Added error message to handle errors

//   const PostsState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.imageName,
//     this.posts = const [], // Initialize with an empty list
//     this.error,
//   });

//   const PostsState.initial()
//       : isLoading = false,
//         isSuccess = false,
//         imageName = null,
//         posts = const [],
//         error = null;

//   PostsState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     String? imageName,
//     List<PostsEntity>? posts,
//     String? error,
//   }) {
//     return PostsState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       imageName: imageName ?? this.imageName,
//       posts: posts ?? this.posts,
//       error: error ?? this.error,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, isSuccess, imageName, posts, error];
// }

// part of 'posts_bloc.dart';

// class PostsState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final String? imageName;
//   final List<PostsEntity> posts;
//   final PostsEntity? selectedPost; // ✅ Added selectedPost for single post
//   final String? error;

//   const PostsState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.imageName,
//     this.posts = const [],
//     this.selectedPost, // ✅ Default is null
//     this.error,
//   });

//   /// ✅ Initial state with default values
//   const PostsState.initial()
//       : isLoading = false,
//         isSuccess = false,
//         imageName = null,
//         posts = const [],
//         selectedPost = null, // ✅ Initial state for selectedPost
//         error = null;

//   /// ✅ Allow updating state with `copyWith`
//   PostsState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     String? imageName,
//     List<PostsEntity>? posts,
//     PostsEntity? selectedPost, // ✅ Added selectedPost
//     String? error,
//   }) {
//     return PostsState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       imageName: imageName ?? this.imageName,
//       posts: posts ?? this.posts,
//       selectedPost: selectedPost ?? this.selectedPost, // ✅ Keep new post
//       error: error ?? this.error,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [isLoading, isSuccess, imageName, posts, selectedPost, error];
// }

part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final List<PostsEntity> posts;
  final PostsEntity? selectedPost; // ✅ Stores a single post when needed
  final String? error;

  const PostsState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.posts = const [],
    this.selectedPost,
    this.error,
  });

  /// ✅ Initial state with default values
  const PostsState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        posts = const [],
        selectedPost = null,
        error = null;

  /// ✅ Allow updating state with `copyWith`
  PostsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    List<PostsEntity>? posts,
    PostsEntity? selectedPost,
    String? error,
  }) {
    return PostsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      posts: posts ?? this.posts,
      selectedPost: selectedPost ?? this.selectedPost,
      error: isSuccess == true ? null : error, // ✅ Reset error on success
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, imageName, posts, selectedPost, error];
}
