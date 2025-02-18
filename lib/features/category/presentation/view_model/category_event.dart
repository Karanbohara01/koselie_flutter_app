// part of 'category_bloc.dart';

// @immutable
// sealed class CategoryEvent extends Equatable {
//   const CategoryEvent();

//   @override
//   List<Object> get props => [];
// }

// final class LoadCategories extends CategoryEvent {}

// final class AddCategory extends CategoryEvent {
//   final String name;
//   const AddCategory(this.name);

//   @override
//   List<Object> get props => [name];
// }

// final class DeleteCategory extends CategoryEvent {
//   final String categoryId;

//   const DeleteCategory(this.categoryId);

//   @override
//   List<Object> get props => [categoryId];
// }

part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class LoadCategories extends CategoryEvent {}

final class AddCategory extends CategoryEvent {
  final String name;
  final void Function(String message)? onSuccess; // ✅ Success callback

  const AddCategory(this.name, {this.onSuccess});

  @override
  List<Object> get props => [name];
}

final class DeleteCategory extends CategoryEvent {
  final String categoryId;
  final void Function(String message)? onSuccess; // ✅ Success callback

  const DeleteCategory(this.categoryId, {this.onSuccess});

  @override
  List<Object> get props => [categoryId];
}
