import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/domain/usecase/create_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/delete_category_usecase.dart';
import 'package:koselie/features/category/domain/usecase/get_all_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CreateCategoryUseCase _createCategoryUseCase;
  final GetAllCategoryUseCase _getAllCategoryUseCase;
  final DeleteCategoryUsecase _deleteCategoryUsecase;

  CategoryBloc({
    required CreateCategoryUseCase createCategoryUseCase,
    required GetAllCategoryUseCase getAllCategoryUseCase,
    required DeleteCategoryUsecase deleteCategoryUsecase,
  })  : _createCategoryUseCase = createCategoryUseCase,
        _getAllCategoryUseCase = getAllCategoryUseCase,
        _deleteCategoryUsecase = deleteCategoryUsecase,
        super(CategoryState.initial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<DeleteCategory>(_onDeleteCategory);

    // Call this event whenever the bloc is created to load the categories
    add(LoadCategories());
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCategoryUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) =>
          emit(state.copyWith(isLoading: false, categories: categories)),
    );
  }

  Future<void> _onAddCategory(
      AddCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCategoryUseCase
        .call(CreateCategoryParams(name: event.name));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadCategories());
      },
    );
  }

  Future<void> _onDeleteCategory(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteCategoryUsecase
        .call(DeleteCategoryParams(categoryId: event.categoryId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadCategories());
      },
    );
  }
}
