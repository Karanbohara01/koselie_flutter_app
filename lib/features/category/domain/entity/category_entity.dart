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

  factory CategoryEntity.fromJson(Map<dynamic, dynamic> json) {
    return CategoryEntity(
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
    };
  }
}
