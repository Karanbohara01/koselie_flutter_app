// import 'dart:io';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/category/domain/entity/category_entity.dart';
// import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/domain/usecase/create_posts_usecase.dart';
// import 'package:koselie/features/posts/domain/usecase/get_all_posts_usecase.dart';
// import 'package:koselie/features/posts/domain/usecase/upload_posts_image_usecase.dart';

// part 'posts_event.dart';
// part 'posts_state.dart';

// class PostsBloc extends Bloc<PostsEvent, PostsState> {
//   final CategoryBloc _categoryBloc;
//   final CreatePostsUseCase _createPostsUseCase;
//   final UploadPostsImageUsecase _uploadPostsImageUsecase;
//   final GetAllPostsUseCase _getAllPostsUseCase;
//   PostsBloc({
//     required CategoryBloc categoryBloc,
//     required CreatePostsUseCase createPostsUseCase,
//     required UploadPostsImageUsecase uploadPostsImageUsecase,
//     required GetAllPostsUseCase getAllPostsUseCase, // Inject GetAllPostsUseCase
//   })  : _categoryBloc = categoryBloc,
//         _createPostsUseCase = createPostsUseCase,
//         _uploadPostsImageUsecase = uploadPostsImageUsecase,
//         _getAllPostsUseCase = getAllPostsUseCase,
//         super(const PostsState.initial()) {
//     // Handle events
//     on<LoadCategories>(_onLoadCategories);
//     on<CreatePost>(_onCreatePost);
//     on<UploadPostsImage>(_onUploadPostsImage);
//     on<LoadPosts>(_onLoadPosts);

//     // Load categories initially
//     add(LoadCategories());
//   }

//   // Handle LoadCategories event
//   void _onLoadCategories(
//     LoadCategories event,
//     Emitter<PostsState> emit,
//   ) {
//     emit(state.copyWith(isLoading: true));
//     // Dispatch the category load event to the CategoryBloc
//     _categoryBloc.add(LoadCategories() as CategoryEvent);

//     emit(state.copyWith(isLoading: false, isSuccess: true));
//   }

//   // Handle CreatePost event
//   void _onCreatePost(
//     CreatePost event,
//     Emitter<PostsState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));

//     // Make an API call to create the post
//     final result = await _createPostsUseCase.call(CreatePostsParams(
//       caption: event.caption,
//       location: event.location,
//       description: event.description,
//       category: event.category,
//       image: state.imageName,
//       price: event.price,
//     ));

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, isSuccess: false));
//         showMySnackBar(
//             context: event.context,
//             message: failure.message,
//             color: Colors.red);
//       },
//       (success) {
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//         showMySnackBar(
//             context: event.context, message: "Post creation successful");
//       },
//     );
//   }

//   // Handle LoadPosts event
//   void _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _getAllPostsUseCase.call();

//     result.fold(
//       (failure) {
//         emit(state.copyWith(
//             isLoading: false, isSuccess: false, error: failure.message));
//         showMySnackBar(
//           context: event.context, // Pass context from event
//           message: failure.message,
//           color: Colors.red,
//         );
//       },
//       (posts) {
//         emit(state.copyWith(isLoading: false, isSuccess: true, posts: posts));
//       },
//     );
//   }

//   // Handle UploadPostsImage event
//   void _onUploadPostsImage(
//     UploadPostsImage event,
//     Emitter<PostsState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));

//     // Call the use case for uploading the image
//     final result = await _uploadPostsImageUsecase.call(
//       UploadPostsImageParams(file: event.file),
//     );

//     result.fold(
//       (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
//       (imageName) {
//         emit(state.copyWith(
//             isLoading: false, isSuccess: true, imageName: imageName));
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/usecase/create_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_all_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_post_by_id_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/upload_posts_image_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final CategoryBloc _categoryBloc;
  final CreatePostsUseCase _createPostsUseCase;
  final UploadPostsImageUsecase _uploadPostsImageUsecase;
  final GetAllPostsUseCase _getAllPostsUseCase;
  final GetPostByIdUseCase _getPostByIdUseCase; // ✅ Added Use Case

  PostsBloc({
    required CategoryBloc categoryBloc,
    required CreatePostsUseCase createPostsUseCase,
    required UploadPostsImageUsecase uploadPostsImageUsecase,
    required GetAllPostsUseCase getAllPostsUseCase,
    required GetPostByIdUseCase getPostByIdUseCase, // ✅ Injected Use Case
  })  : _categoryBloc = categoryBloc,
        _createPostsUseCase = createPostsUseCase,
        _uploadPostsImageUsecase = uploadPostsImageUsecase,
        _getAllPostsUseCase = getAllPostsUseCase,
        _getPostByIdUseCase = getPostByIdUseCase, // ✅ Initialized
        super(const PostsState.initial()) {
    // Handle events
    on<LoadCategories>(_onLoadCategories);
    on<CreatePost>(_onCreatePost);
    on<UploadPostsImage>(_onUploadPostsImage);
    on<LoadPosts>(_onLoadPosts);
    on<GetPostById>(
        _onGetPostById); // ✅ Added handler for fetching a post by ID

    // Load categories initially
    add(LoadCategories());
  }

  // Handle LoadCategories event
  void _onLoadCategories(
    LoadCategories event,
    Emitter<PostsState> emit,
  ) {
    emit(state.copyWith(isLoading: true));
    _categoryBloc.add(LoadCategories() as CategoryEvent);
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  // Handle CreatePost event
  void _onCreatePost(
    CreatePost event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _createPostsUseCase.call(CreatePostsParams(
        caption: event.caption,
        location: event.location,
        description: event.description,
        category: event.category,
        image: state.imageName,
        price: event.price));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context,
            message: failure.message,
            color: Colors.red);
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Post creation successful");
      },
    );
  }

  // Handle LoadPosts event
  void _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllPostsUseCase.call();

    result.fold(
      (failure) {
        emit(state.copyWith(
            isLoading: false, isSuccess: false, error: failure.message));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
      (posts) {
        emit(state.copyWith(isLoading: false, isSuccess: true, posts: posts));
      },
    );
  }

  void _onGetPostById(
    GetPostById event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await _getPostByIdUseCase.call(GetPostByIdParams(postId: event.postId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));

        // ✅ Only show Snackbar if widget is still mounted
        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: failure.message,
            color: Colors.red,
          );
        }
      },
      (post) {
        emit(state.copyWith(isLoading: false, selectedPost: post));
      },
    );
  }

  // Handle UploadPostsImage event
  void _onUploadPostsImage(
    UploadPostsImage event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _uploadPostsImageUsecase.call(
      UploadPostsImageParams(file: event.file),
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (imageName) {
        emit(state.copyWith(
            isLoading: false, isSuccess: true, imageName: imageName));
      },
    );
  }
}
