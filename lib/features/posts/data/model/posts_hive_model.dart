// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';
import 'package:koselie/features/category/data/model/category_hive_model.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:uuid/uuid.dart';

part 'posts_hive_model.g.dart';
// flutter pub run build_runner build

@HiveType(typeId: HiveTableConstant.postTableId)
class PostsHiveModel extends Equatable {
  @HiveField(0)
  final String? postId;
  @HiveField(1)
  final String caption;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String location;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final CategoryHiveModel category;

  PostsHiveModel({
    String? postId,
    required this.caption,
    required this.description,
    required this.price,
    required this.location,
    required this.category,
    this.image,
  }) : postId = postId ?? const Uuid().v4();

  // Initial Constructor
  const PostsHiveModel.initial()
      : postId = '',
        caption = '',
        location = '',
        price = '',
        description = '',
        category = const CategoryHiveModel.initial(),
        image = '';

  // From Entity
  factory PostsHiveModel.fromEntity(PostsEntity entity) {
    return PostsHiveModel(
      postId: entity.postId,
      caption: entity.caption,
      description: entity.description,
      price: entity.price,
      location: entity.location,
      image: entity.image,
      category: CategoryHiveModel.fromEntity(entity.category),
    );
  }

  // To Entity
  PostsEntity toEntity() {
    return PostsEntity(
      postId: postId,
      caption: caption,
      description: description,
      price: price,
      location: location,
      image: image,
      category: category.toEntity(),
    );
  }

  @override
  List<Object?> get props =>
      [postId, caption, location, description, price, image, category];
}
