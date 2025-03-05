// part of 'posts_bloc.dart';

// class PostsState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final String? imageName;
//   final List<PostsEntity> posts;
//   final PostsEntity? selectedPost; // ✅ Stores a single post when needed
//   final String? error;
//   final String? deletedPostId; // ✅ Stores the ID of a deleted post

//   const PostsState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.imageName,
//     this.posts = const [],
//     this.selectedPost,
//     this.error,
//     this.deletedPostId, // ✅ Added deletedPostId
//   });

// /// ✅ Initial state with default values
// const PostsState.initial()
//     : isLoading = false,
//       isSuccess = false,
//       imageName = null,
//       posts = const [],
//       selectedPost = null,
//       error = null,
//       deletedPostId = null;

//   /// ✅ Allow updating state with `copyWith`
//   PostsState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     String? imageName,
//     List<PostsEntity>? posts,
//     PostsEntity? selectedPost,
//     String? error,
//     String? deletedPostId, // ✅ Add deletedPostId parameter
//   }) {
//     return PostsState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       imageName: imageName ?? this.imageName,
//       posts: posts ?? this.posts,
//       selectedPost: selectedPost ?? this.selectedPost,
//       error: error, // Keep the error as is for now
//       deletedPostId: deletedPostId ?? this.deletedPostId, // Preserve old value
//     );
//   }

//   @override
//   List<Object?> get props => [
//         isLoading,
//         isSuccess,
//         imageName,
//         posts,
//         selectedPost,
//         error,
//         deletedPostId
//       ];
// }
part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final List<PostsEntity> posts;
  final PostsEntity? selectedPost;
  final Map<String, List<CommentEntity>>
      postComments; // ✅ Store comments per post
  final String? error;
  final String? deletedPostId;

  const PostsState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.posts = const [],
    this.selectedPost,
    this.postComments = const {}, // ✅ Ensure comments are mapped per post
    this.error,
    this.deletedPostId,
  });

  /// ✅ Allow updating state with `copyWith`
  PostsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    List<PostsEntity>? posts,
    PostsEntity? selectedPost,
    String? error,
    String? deletedPostId,
    Map<String, List<CommentEntity>>? postComments,
  }) {
    return PostsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      posts: posts ?? this.posts,
      selectedPost: selectedPost ?? this.selectedPost,
      error: error ?? this.error,
      deletedPostId: deletedPostId ?? this.deletedPostId,
      postComments:
          postComments ?? this.postComments, // ✅ Preserve correct comments
    );
  }

  /// ✅ Initial state
  const PostsState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        posts = const [],
        selectedPost = null,
        postComments = const {}, // ✅ Initialize empty comment map
        error = null,
        deletedPostId = null;

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        imageName,
        posts,
        selectedPost,
        postComments, // ✅ Ensure it's included in state updates
        error,
        deletedPostId,
      ];
}
