import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:uuid/uuid.dart';

part 'category_hive_model.g.dart';
// flutter pub run build_runner build

@HiveType(typeId: HiveTableConstant.categoryTableId)
class CategoryHiveModel extends Equatable {
  @HiveField(0)
  final String? categoryId;
  @HiveField(1)
  final String name;

  CategoryHiveModel({
    String? categoryId,
    required this.name,
  }) : categoryId = categoryId ?? const Uuid().v4();

  // Initail Constructor
  const CategoryHiveModel.initial()
      : categoryId = '',
        name = '';

  // From Entity
  factory CategoryHiveModel.fromEntity(CategoryEntity entity) {
    return CategoryHiveModel(
      categoryId: entity.categoryId,
      name: entity.name,
    );
  }

  // To Entity
  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
    );
  }

  @override
  List<Object?> get props => [categoryId, name];
}



  // // // From Entity List
  // // static List<BatchHiveModel> fromEntityList(List<BatchEntity> entityList) {
  // //   return entityList
  // //       .map((entity) => BatchHiveModel.fromEntity(entity))
  // //       .toList();
  // // }

  // // To Entity List
  // static List<BatchEntity> toEntityList(List<BatchHiveModel> hiveList) {
  //   return hiveList.map((hive) => hive.toEntity()).toList();
  // }