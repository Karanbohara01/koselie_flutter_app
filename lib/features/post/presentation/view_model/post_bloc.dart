import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/post/domain/usecase/create_post_usecase.dart';
import 'package:koselie/features/post/domain/usecase/delete_post_usecase.dart';
import 'package:koselie/features/post/domain/usecase/get_all_post_usecase.dart';
import 'package:koselie/features/post/presentation/view_model/post_event.dart';
import 'package:koselie/features/post/presentation/view_model/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostUsecase _getAllPostsUsecase;
  final CreatePostUsecase _createPostUsecase;
  final DeletePostUsecase _deletePostUsecase;

  PostBloc({
    required GetAllPostUsecase getAllPostsUsecase,
    required CreatePostUsecase createPostUsecase,
    required DeletePostUsecase deletePostUsecase,
  })  : _getAllPostsUsecase = getAllPostsUsecase,
        _createPostUsecase = createPostUsecase,
        _deletePostUsecase = deletePostUsecase,
        super(PostInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<CreatePost>(_onCreatePost);
    on<DeletePost>(_onDeletePost);
  }
  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final result = await _getAllPostsUsecase.call();
    result.fold(
      (failure) => emit(PostFailure(message: failure.message)),
      (posts) => emit(PostSuccess(posts: posts)),
    );
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(PostLoading()); // Or a more specific "CreatingPost" state

    final result = await _createPostUsecase.call(
      CreatePostParams(
        caption: event.caption,
        price: event.price,
        description: event.description,
        location: event.location,
        image: event.image,
        authorId: event.authorId,
        likeIds: event.likeIds,
        commentIds: event.commentIds,
        categoryIds: event.categoryIds,
      ),
    );

    result.fold(
      (failure) => emit(PostFailure(message: failure.message)),
      (_) {
        // After successful creation, reload the posts
        add(LoadPosts()); // Trigger the LoadPosts event to refresh the list
      },
    );
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(PostLoading()); // Or a more specific "DeletingPost" state

    final result = await _deletePostUsecase.call(event.postId);

    result.fold(
      (failure) => emit(PostFailure(message: failure.message)),
      (_) {
        // After successful deletion, reload the posts
        add(LoadPosts()); // Trigger the LoadPosts event to refresh the list
      },
    );
  }
}
