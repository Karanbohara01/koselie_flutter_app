// part of 'posts_bloc.dart';

// class PostsState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final String? imageName;

//   const PostsState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.imageName,
//   });

//   const PostsState.initial()
//       : isLoading = false,
//         isSuccess = false,
//         imageName = null;

//   PostsState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     String? imageName,
//   }) {
//     return PostsState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       imageName: imageName ?? this.imageName,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, isSuccess, imageName];
// }

part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final List<PostsEntity> posts; // Added list of posts
  final String? error; // Added error message to handle errors

  const PostsState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.posts = const [], // Initialize with an empty list
    this.error,
  });

  const PostsState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        posts = const [],
        error = null;

  PostsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    List<PostsEntity>? posts,
    String? error,
  }) {
    return PostsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName, posts, error];
}
