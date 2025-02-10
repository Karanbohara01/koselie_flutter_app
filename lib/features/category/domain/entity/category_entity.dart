import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? categoryId;
  final String name;

  const CategoryEntity({
    this.categoryId,
    required this.name,
  });

  // Empty constructor
  const CategoryEntity.empty()
      : categoryId = '_empty.categoryId',
        name = '_empty.name';

  @override
  List<Object?> get props => [categoryId, name];
}
