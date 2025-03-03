import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/domain/usecase/create_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/delete_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/get_all_category_usecase.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock classes
class MockCreateCategoryUseCase extends Mock implements CreateCategoryUseCase {}

class MockGetAllCategoryUseCase extends Mock implements GetAllCategoryUseCase {}

class MockDeleteCategoryUseCase extends Mock implements DeleteCategoryUsecase {}

// ✅ Fallback values for mocktail
class FakeCreateCategoryParams extends Fake implements CreateCategoryParams {}

class FakeDeleteCategoryParams extends Fake implements DeleteCategoryParams {}

void main() {
  late CategoryBloc categoryBloc;
  late MockCreateCategoryUseCase mockCreateCategoryUseCase;
  late MockGetAllCategoryUseCase mockGetAllCategoryUseCase;
  late MockDeleteCategoryUseCase mockDeleteCategoryUseCase;

  // ✅ Sample categories for testing
  final categoryList = [
    const CategoryEntity(categoryId: '1', name: 'Electronics'),
    const CategoryEntity(categoryId: '2', name: 'Fashion'),
  ];

  setUpAll(() {
    registerFallbackValue(FakeCreateCategoryParams());
    registerFallbackValue(FakeDeleteCategoryParams());
  });

  setUp(() {
    mockCreateCategoryUseCase = MockCreateCategoryUseCase();
    mockGetAllCategoryUseCase = MockGetAllCategoryUseCase();
    mockDeleteCategoryUseCase = MockDeleteCategoryUseCase();

    // ✅ Ensure getAllCategoryUseCase returns valid data
    when(() => mockGetAllCategoryUseCase.call())
        .thenAnswer((_) async => Right(categoryList));

    categoryBloc = CategoryBloc(
      createCategoryUseCase: mockCreateCategoryUseCase,
      getAllCategoryUseCase: mockGetAllCategoryUseCase,
      deleteCategoryUsecase: mockDeleteCategoryUseCase,
    );
  });

  tearDown(() {
    categoryBloc.close();
  });

  // ✅ 1️⃣ Initial State Test
  test('Initial state is CategoryState.initial() with loading true', () {
    expect(categoryBloc.state,
        equals(CategoryState.initial().copyWith(isLoading: true)));
  });

  // ✅ 2️⃣ Load Categories - Success
  blocTest<CategoryBloc, CategoryState>(
    'emits [loading, loaded] when LoadCategories is successful',
    build: () => categoryBloc,
    act: (bloc) => bloc.add(LoadCategories()),
    expect: () => [
      CategoryState.initial().copyWith(isLoading: true),
      CategoryState.initial()
          .copyWith(categories: categoryList, isLoading: false),
    ],
  );

  // ✅ 3️⃣ Load Categories - Failure
  blocTest<CategoryBloc, CategoryState>(
    'emits [loading, error] when LoadCategories fails',
    build: () {
      when(() => mockGetAllCategoryUseCase.call())
          .thenAnswer((_) async => Left(Failure(message: '')));
      return categoryBloc;
    },
    act: (bloc) => bloc.add(LoadCategories()),
    expect: () => [
      CategoryState.initial().copyWith(isLoading: true),
      CategoryState.initial()
          .copyWith(isLoading: false, error: 'Failed to load categories'),
    ],
  );

  // ✅ 4️⃣ Add Category - Success
  blocTest<CategoryBloc, CategoryState>(
    'emits [loading, loaded] when AddCategory is successful',
    build: () {
      when(() => mockCreateCategoryUseCase.call(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockGetAllCategoryUseCase.call())
          .thenAnswer((_) async => Right(categoryList));

      return categoryBloc;
    },
    act: (bloc) => bloc.add(const AddCategory('Books')),
    expect: () => [
      CategoryState.initial().copyWith(isLoading: true),
      CategoryState.initial().copyWith(isLoading: false),
      CategoryState.initial()
          .copyWith(categories: categoryList, isLoading: false),
    ],
  );

  // ✅ 5️⃣ Add Category - Failure
  blocTest<CategoryBloc, CategoryState>(
    'emits [loading, error] when AddCategory fails',
    build: () {
      when(() => mockCreateCategoryUseCase.call(any()))
          .thenAnswer((_) async => Left(Failure(message: '')));
      return categoryBloc;
    },
    act: (bloc) => bloc.add(const AddCategory('Books')),
    expect: () => [
      CategoryState.initial().copyWith(isLoading: true),
      CategoryState.initial()
          .copyWith(isLoading: false, error: 'Failed to create category'),
    ],
  );

  // ✅ 6️⃣ Delete Category - Success
  blocTest<CategoryBloc, CategoryState>(
    'emits [loading, loaded] when DeleteCategory is successful',
    build: () {
      when(() => mockDeleteCategoryUseCase.call(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockGetAllCategoryUseCase.call())
          .thenAnswer((_) async => const Right([]));

      return categoryBloc;
    },
    act: (bloc) => bloc.add(const DeleteCategory('1')),
    expect: () => [
      CategoryState.initial().copyWith(isLoading: true),
      CategoryState.initial().copyWith(isLoading: false),
      CategoryState.initial().copyWith(categories: [], isLoading: false),
    ],
  );

  // ✅ 7️⃣ Delete Category - Failure
  blocTest<CategoryBloc, CategoryState>(
    'emits [loading, error] when DeleteCategory fails',
    build: () {
      when(() => mockDeleteCategoryUseCase.call(any()))
          .thenAnswer((_) async => Left(Failure(message: '')));
      return categoryBloc;
    },
    act: (bloc) => bloc.add(const DeleteCategory('1')),
    expect: () => [
      CategoryState.initial().copyWith(isLoading: true),
      CategoryState.initial()
          .copyWith(isLoading: false, error: 'Failed to delete category'),
    ],
  );
}
