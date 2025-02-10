import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';

@JsonSerializable()
class CategoryApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? categoryId;
  final String name;

  const CategoryApiModel({
    this.categoryId,
    required this.name,
  });

  const CategoryApiModel.empty()
      : categoryId = '',
        name = '';

  // From Json , write full code without generator
  factory CategoryApiModel.fromJson(Map<String, dynamic> json) {
    return CategoryApiModel(
      categoryId: json['_id'],
      name: json['name'],
    );
  }

  // To Json , write full code without generator
  Map<String, dynamic> toJson() {
    return {
      '_id': categoryId,
      'name': name,
    };
  }

  // Convert API Object to Entity
  CategoryEntity toEntity() => CategoryEntity(
        categoryId: categoryId,
        name: name,
      );

  // Convert Entity to API Object
  static CategoryApiModel fromEntity(CategoryEntity entity) => CategoryApiModel(
        name: entity.name,
      );

  // Convert API List to Entity List
  static List<CategoryEntity> toEntityList(List<CategoryApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        categoryId,
        name,
      ];
}
