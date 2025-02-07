// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/post/domain/entity/post_entity.dart';
// import 'package:koselie/features/post/domain/usecase/create_post_usecase.dart';
// import 'package:koselie/features/post/domain/usecase/delete_post_usecase.dart';
// import 'package:koselie/features/post/domain/usecase/get_all_post_usecase.dart';
// import 'package:koselie/features/post/presentation/view_model/post_bloc.dart';
// import 'package:koselie/features/post/presentation/view_model/post_event.dart';
// import 'package:koselie/features/post/presentation/view_model/post_state.dart';
// import 'package:mocktail/mocktail.dart'; // Import mocktail

// // Create mock classes for the use cases
// class MockGetAllPostsUsecase extends Mock implements GetAllPostUsecase {}

// class MockCreatePostUsecase extends Mock implements CreatePostUsecase {}

// class MockDeletePostUsecase extends Mock implements DeletePostUsecase {}

// void main() {
//   setUpAll(() {
//     registerFallbackValue(const CreatePostParams(
//       caption: '',
//       price: '',
//       description: '',
//       location: '',
//       image: '',
//       authorId: '',
//       likeIds: [],
//       commentIds: [],
//       categoryIds: [],
//     ));
//   });
//   group('PostBloc', () {
//     late MockGetAllPostsUsecase mockGetAllPostsUsecase;
//     late MockCreatePostUsecase mockCreatePostUsecase;
//     late MockDeletePostUsecase mockDeletePostUsecase;
//     late PostBloc postBloc;

//     setUp(() {
//       mockGetAllPostsUsecase = MockGetAllPostsUsecase();
//       mockCreatePostUsecase = MockCreatePostUsecase();
//       mockDeletePostUsecase = MockDeletePostUsecase();
//       postBloc = PostBloc(
//         getAllPostsUsecase: mockGetAllPostsUsecase,
//         createPostUsecase: mockCreatePostUsecase,
//         deletePostUsecase: mockDeletePostUsecase,
//       );
//     });

//     tearDown(() {
//       postBloc.close();
//     });

//     const testPost = PostEntity(
//       postId: '1',
//       caption: 'Test Post',
//       price: '10',
//       description: 'Test Description',
//       location: 'Test Location',
//       image: 'Test Image',
//       authorId: 'Test Author',
//       likeIds: [],
//       commentIds: [],
//       categoryIds: [],
//     );

//     group('LoadPosts', () {
//       blocTest<PostBloc, PostState>(
//         'emits [PostLoading, PostSuccess] when GetAllPostsUsecase returns Right(posts)',
//         setUp: () {
//           when(() => mockGetAllPostsUsecase.call())
//               .thenAnswer((_) async => const Right([testPost]));
//         },
//         build: () => postBloc,
//         act: (bloc) => bloc.add(LoadPosts()),
//         expect: () => [
//           PostLoading(),
//           const PostSuccess(posts: [testPost]),
//         ],
//       );

//       blocTest<PostBloc, PostState>(
//         'emits [PostLoading, PostFailure] when GetAllPostsUsecase returns Left(failure)',
//         setUp: () {
//           when(() => mockGetAllPostsUsecase.call()).thenAnswer(
//               (_) async => Left(ServerFailure('Test Error', message: '')));
//         },
//         build: () => postBloc,
//         act: (bloc) => bloc.add(LoadPosts()),
//         expect: () => [
//           PostLoading(),
//           const PostFailure(message: 'Test Error'),
//         ],
//       );
//     });

//     group('CreatePost', () {
//       blocTest<PostBloc, PostState>(
//         'emits [PostLoading, PostSuccess] and reloads posts when CreatePostUsecase returns Right(unit)',
//         setUp: () {
//           when(() => mockCreatePostUsecase.call(any()))
//               .thenAnswer((_) async => const Right(unit));
//           when(() => mockGetAllPostsUsecase.call())
//               .thenAnswer((_) async => const Right([testPost]));
//         },
//         build: () => postBloc,
//         act: (bloc) => bloc.add(
//           const CreatePost(
//             caption: 'Test Post',
//             price: '10',
//             description: 'Test Description',
//             location: 'Test Location',
//             image: 'Test Image',
//             authorId: 'Test Author',
//             likeIds: [],
//             commentIds: [],
//             categoryIds: [],
//           ),
//         ),
//         expect: () => [
//           PostLoading(),
//           const PostSuccess(posts: [testPost]),
//         ],
//         verify: (_) {
//           verify(() => mockCreatePostUsecase.call(any())).called(1);
//           verify(() => mockGetAllPostsUsecase.call()).called(1);
//         },
//       );

//       blocTest<PostBloc, PostState>(
//         'emits [PostLoading, PostFailure] when CreatePostUsecase returns Left(failure)',
//         setUp: () {
//           when(() => mockCreatePostUsecase.call(any())).thenAnswer(
//               (_) async => Left(ServerFailure('Test Error', message: '')));
//         },
//         build: () => postBloc,
//         act: (bloc) => bloc.add(
//           const CreatePost(
//             caption: 'Test Post',
//             price: '10',
//             description: 'Test Description',
//             location: 'Test Location',
//             image: 'Test Image',
//             authorId: 'Test Author',
//             likeIds: [],
//             commentIds: [],
//             categoryIds: [],
//           ),
//         ),
//         expect: () => [
//           PostLoading(),
//           const PostFailure(message: 'Test Error'),
//         ],
//         verify: (_) {
//           verify(() => mockCreatePostUsecase.call(any())).called(1);
//         },
//       );
//     });

//     group('DeletePost', () {
//       blocTest<PostBloc, PostState>(
//         'emits [PostLoading, PostSuccess] and reloads posts when DeletePostUsecase returns Right(unit)',
//         setUp: () {
//           when(() => mockDeletePostUsecase.call(any()))
//               .thenAnswer((_) async => const Right(unit));
//           when(() => mockGetAllPostsUsecase.call())
//               .thenAnswer((_) async => const Right([testPost]));
//         },
//         build: () => postBloc,
//         act: (bloc) => bloc.add(const DeletePost(postId: '1', '1')),
//         expect: () => [
//           PostLoading(),
//           const PostSuccess(posts: [testPost]),
//         ],
//         verify: (_) {
//           verify(() => mockDeletePostUsecase.call(any())).called(1);
//           verify(() => mockGetAllPostsUsecase.call()).called(1);
//         },
//       );

//       blocTest<PostBloc, PostState>(
//         'emits [PostLoading, PostFailure] when DeletePostUsecase returns Left(failure)',
//         setUp: () {
//           when(() => mockDeletePostUsecase.call(any())).thenAnswer(
//               (_) async => Left(ServerFailure('Test Error', message: '')));
//         },
//         build: () => postBloc,
//         act: (bloc) => bloc.add(const DeletePost(postId: '1', '1')),
//         expect: () => [
//           PostLoading(),
//           const PostFailure(message: 'Test Error'),
//         ],
//         verify: (_) {
//           verify(() => mockDeletePostUsecase.call(any())).called(1);
//         },
//       );
//     });
//   });
// }
