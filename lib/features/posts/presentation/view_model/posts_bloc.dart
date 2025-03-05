import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/comment/domain/usecase/add_comment_usecase.dart';
import 'package:koselie/features/comment/domain/usecase/get_comments_usecase.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/usecase/create_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/delete_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_all_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_post_by_id_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/upload_posts_image_usecase.dart';
import 'package:koselie/features/posts/service/connectivity_service.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final CategoryBloc _categoryBloc;
  final CreatePostsUseCase _createPostsUseCase;
  final UploadPostsImageUsecase _uploadPostsImageUsecase;
  final GetAllPostsUseCase _getAllPostsUseCase;
  final GetPostByIdUseCase _getPostByIdUseCase;
  final DeletePostsUsecase _deletePostUseCase;
  final UpdatePostsUsecase _updatePostsUseCase;
  final ConnectivityService connectivityService; // Inject ConnectivityService
  // ✅ New: Use Cases for Comments
  final AddCommentUseCase _addCommentUseCase;
  final GetCommentsUseCase _getCommentsUseCase;
  PostsBloc({
    required CategoryBloc categoryBloc,
    required CreatePostsUseCase createPostsUseCase,
    required UploadPostsImageUsecase uploadPostsImageUsecase,
    required GetAllPostsUseCase getAllPostsUseCase,
    required GetPostByIdUseCase getPostByIdUseCase,
    required DeletePostsUsecase deletePostUseCase,
    required UpdatePostsUsecase updatePostsUseCase,
    required this.connectivityService, // Initialize ConnectivityService
    required AddCommentUseCase addCommentUseCase, // ✅ Inject Comment UseCase
    required GetCommentsUseCase getCommentsUseCase, // ✅ Inject Comment UseCase
  })  : _categoryBloc = categoryBloc,
        _createPostsUseCase = createPostsUseCase,
        _uploadPostsImageUsecase = uploadPostsImageUsecase,
        _getAllPostsUseCase = getAllPostsUseCase,
        _getPostByIdUseCase = getPostByIdUseCase,
        _deletePostUseCase = deletePostUseCase,
        _updatePostsUseCase = updatePostsUseCase,
        _addCommentUseCase = addCommentUseCase,
        _getCommentsUseCase = getCommentsUseCase,
        super(const PostsState.initial()) {
    on<LoadCategories>(_onLoadCategories);
    on<CreatePost>(_onCreatePost);
    on<UploadPostsImage>(_onUploadPostsImage);
    on<LoadPosts>(_onLoadPosts);
    on<DeletePost>(_onDeletePost);
    on<GetPostById>(_onGetPostById);
    on<UpdatePost>(_onUpdatePost);
    on<AddComment>(_onAddComment); // ✅ Handle Add Comment
    on<GetComments>(_onGetComments); // ✅ Handle Fetch Comments

    add(LoadCategories());
  }

  void _onLoadCategories(
    LoadCategories event,
    Emitter<PostsState> emit,
  ) {
    _categoryBloc.add(LoadCategories() as CategoryEvent);
  }

  void _onUpdatePost(
    UpdatePost event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _updatePostsUseCase.call(
      UpdatePostsParams(postId: event.postId, post: event.post),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: failure.message,
            color: Colors.red,
          );
        }
      },
      (success) {
        // ✅ Update post in the list without refetching
        final updatedPosts = state.posts.map((p) {
          return p.postId == event.postId ? event.post : p;
        }).toList();

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          posts: updatedPosts,
        ));

        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: "Post updated successfully",
            color: Colors.green,
          );
        }
      },
    );
  }

  void _onDeletePost(
    DeletePost event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await _deletePostUseCase.call(DeletePostsParams(postId: event.postId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: failure.message,
            color: Colors.red,
          );
        }
      },
      (success) {
        final updatedPosts =
            state.posts.where((post) => post.postId != event.postId).toList();

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          posts: updatedPosts,
        ));

        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: "Post deleted successfully",
            color: Colors.green,
          );
        }
      },
    );
  }

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
      price: event.price,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: failure.message,
            color: Colors.red,
          );
        }
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        if (event.context.mounted) {
          showMySnackBar(
            context: event.context,
            message: "Post creation successful",
          );
        }
      },
    );
  }

  void _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await _getAllPostsUseCase.call();

      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: failure.message,
          ));
          if (event.context.mounted) {
            showMySnackBar(
              context: event.context,
              message: failure.message,
              color: Colors.red,
            );
          }
        },
        (posts) {
          emit(state.copyWith(isLoading: false, isSuccess: true, posts: posts));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isSuccess: false, error: e.toString()));
    }
  }

  // void _onGetPostById(
  //   GetPostById event,
  //   Emitter<PostsState> emit,
  // ) async {
  //   emit(state.copyWith(isLoading: true));

  //   final result =
  //       await _getPostByIdUseCase.call(GetPostByIdParams(postId: event.postId));

  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(isLoading: false, error: failure.message));
  //       if (event.context.mounted) {
  //         showMySnackBar(
  //           context: event.context,
  //           message: failure.message,
  //           color: Colors.red,
  //         );
  //       }
  //     },
  //     (post) {
  //       emit(state.copyWith(isLoading: false, selectedPost: post));

  //     },

  //   );
  // }

  // void _onGetPostById(
  //   GetPostById event,
  //   Emitter<PostsState> emit,
  // ) async {
  //   emit(state.copyWith(isLoading: true));

  //   final result =
  //       await _getPostByIdUseCase.call(GetPostByIdParams(postId: event.postId));

  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(isLoading: false, error: failure.message));
  //       if (event.context.mounted) {
  //         showMySnackBar(
  //           context: event.context,
  //           message: failure.message,
  //           color: Colors.red,
  //         );
  //       }
  //     },
  //     (post) {
  //       emit(state.copyWith(isLoading: false, selectedPost: post));

  //       // ✅ Ensure postId is not null before calling GetComments
  //       // if (post.postId != null) {
  //       //   event.context.read<PostsBloc>().add(GetComments(
  //       //         postId: post.postId!,
  //       //         context: event.context,
  //       //       ));
  //       // }
  //     },
  //   );
  // }

  void _onGetPostById(
    GetPostById event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null)); // Clear previous errors

    final result =
        await _getPostByIdUseCase.call(GetPostByIdParams(postId: event.postId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));

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

        // ✅ Ensure postId is valid before dispatching GetComments
        // if (post.postId != null && post.postId!.isNotEmpty) {
        //   if (event.context.mounted) {
        //     event.context.read<PostsBloc>().add(GetComments(
        //           postId: post.postId!,
        //           context: event.context,
        //         ));
        //   }
        // }
      },
    );
  }

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

  void _onAddComment(
    AddComment event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, error: null));

    final result = await _addCommentUseCase.call(
      AddCommentParams(postId: event.postId, text: event.commentText),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
            isLoading: false, isSuccess: false, error: failure.message));
      },
      (newComment) {
        // ✅ Ensure we are updating only the specific post's comments
        final updatedComments =
            Map<String, List<CommentEntity>>.from(state.postComments);

        if (updatedComments.containsKey(event.postId)) {
          updatedComments[event.postId] = [
            ...updatedComments[event.postId]!,
            newComment, // ✅ Add new comment
          ];
        } else {
          updatedComments[event.postId] = [newComment];
        }

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true, // ✅ Ensure UI recognizes success
          postComments: updatedComments, // ✅ Update only the relevant post
        ));
      },
    );
  }

  void _onGetComments(
    GetComments event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await _getCommentsUseCase.call(GetCommentsParams(postId: event.postId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (comments) {
        final updatedComments =
            Map<String, List<CommentEntity>>.from(state.postComments);
        updatedComments[event.postId] =
            comments; // ✅ Store comments under specific postId

        emit(state.copyWith(isLoading: false, postComments: updatedComments));
      },
    );
  }
}
