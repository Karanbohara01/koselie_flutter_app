import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/domain/usecase/create_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/delete_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_all_posts_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/get_post_by_id_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:koselie/features/posts/domain/usecase/upload_posts_image_usecase.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/posts/service/connectivity_service.dart';
import 'package:mocktail/mocktail.dart';

class MockCreatePostsUseCase extends Mock implements CreatePostsUseCase {}

class MockUploadPostsImageUseCase extends Mock
    implements UploadPostsImageUsecase {}

class MockGetAllPostsUseCase extends Mock implements GetAllPostsUseCase {}

class MockGetPostByIdUseCase extends Mock implements GetPostByIdUseCase {}

class MockDeletePostsUseCase extends Mock implements DeletePostsUsecase {}

class MockUpdatePostsUseCase extends Mock implements UpdatePostsUsecase {}

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  late PostsBloc postsBloc;
  late MockCreatePostsUseCase mockCreatePostsUseCase;
  late MockUploadPostsImageUseCase mockUploadPostsImageUseCase;
  late MockGetAllPostsUseCase mockGetAllPostsUseCase;
  late MockGetPostByIdUseCase mockGetPostByIdUseCase;
  late MockDeletePostsUseCase mockDeletePostsUseCase;
  late MockUpdatePostsUseCase mockUpdatePostsUseCase;
  late MockConnectivityService mockConnectivityService;

  const post = PostsEntity(
    postId: '1',
    caption: 'Test Post',
    location: 'Test Location',
    description: 'Test Description',
    category: 'Test Category',
    image: 'test_image.png',
    price: 100,
  );

  setUp(() {
    mockCreatePostsUseCase = MockCreatePostsUseCase();
    mockUploadPostsImageUseCase = MockUploadPostsImageUseCase();
    mockGetAllPostsUseCase = MockGetAllPostsUseCase();
    mockGetPostByIdUseCase = MockGetPostByIdUseCase();
    mockDeletePostsUseCase = MockDeletePostsUseCase();
    mockUpdatePostsUseCase = MockUpdatePostsUseCase();
    mockConnectivityService = MockConnectivityService();

    postsBloc = PostsBloc(
      categoryBloc: CategoryBloc(),
      createPostsUseCase: mockCreatePostsUseCase,
      uploadPostsImageUsecase: mockUploadPostsImageUseCase,
      getAllPostsUseCase: mockGetAllPostsUseCase,
      getPostByIdUseCase: mockGetPostByIdUseCase,
      deletePostUseCase: mockDeletePostsUseCase,
      updatePostsUseCase: mockUpdatePostsUseCase,
      connectivityService: mockConnectivityService,
    );
  });

  tearDown(() {
    postsBloc.close();
  });

  blocTest<PostsBloc, PostsState>(
    'emits [loading, success] when LoadPosts is successful',
    build: () {
      when(() => mockGetAllPostsUseCase.call())
          .thenAnswer((_) async => const Right([post]));
      return postsBloc;
    },
    act: (bloc) => bloc.add(const LoadPosts()),
    expect: () => [
      const PostsState.initial().copyWith(isLoading: true),
      const PostsState.initial()
          .copyWith(isLoading: false, isSuccess: true, posts: [post]),
    ],
  );

  blocTest<PostsBloc, PostsState>(
    'emits [loading, error] when LoadPosts fails',
    build: () {
      when(() => mockGetAllPostsUseCase.call()).thenAnswer(
          (_) async => Left(Failure(message: 'Failed to load posts')));
      return postsBloc;
    },
    act: (bloc) => bloc.add(const LoadPosts()),
    expect: () => [
      const PostsState.initial().copyWith(isLoading: true),
      const PostsState.initial().copyWith(
          isLoading: false, isSuccess: false, error: 'Failed to load posts'),
    ],
  );

  blocTest<PostsBloc, PostsState>(
    'emits [loading, success] when CreatePost is successful',
    build: () {
      when(() => mockCreatePostsUseCase.call(any()))
          .thenAnswer((_) async => const Right(null));
      return postsBloc;
    },
    act: (bloc) => bloc.add(CreatePost(
      caption: 'Test Caption',
      location: 'Test Location',
      description: 'Test Description',
      category: 'Test Category',
      price: 100,
      context: MockBuildContext(),
    )),
    expect: () => [
      const PostsState.initial().copyWith(isLoading: true),
      const PostsState.initial().copyWith(isLoading: false, isSuccess: true),
    ],
  );

  blocTest<PostsBloc, PostsState>(
    'emits [loading, error] when CreatePost fails',
    build: () {
      when(() => mockCreatePostsUseCase.call(any())).thenAnswer(
          (_) async => Left(Failure(message: 'Failed to create post')));
      return postsBloc;
    },
    act: (bloc) => bloc.add(CreatePost(
      caption: 'Test Caption',
      location: 'Test Location',
      description: 'Test Description',
      category: 'Test Category',
      price: 100,
      context: MockBuildContext(),
    )),
    expect: () => [
      const PostsState.initial().copyWith(isLoading: true),
      const PostsState.initial().copyWith(isLoading: false, isSuccess: false),
    ],
  );
}
