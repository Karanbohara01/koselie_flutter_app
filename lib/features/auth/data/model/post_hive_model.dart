import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';
import 'package:uuid/uuid.dart';

part 'post_hive_model.g.dart'; // Required for Hive

@HiveType(typeId: HiveTableConstant.postTableId)
class PostHiveModel extends Equatable {
  @HiveField(0)
  final String? postId;

  @HiveField(1)
  final String caption;

  @HiveField(2)
  final String price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final String authorId;

  @HiveField(7)
  final List<String> likeIds;

  @HiveField(8)
  final List<String> commentIds;

  @HiveField(9)
  final List<String> categoryIds;

  PostHiveModel({
    String? postId, // No required for postId here
    required this.caption,
    required this.price,
    required this.description,
    required this.location,
    required this.image,
    required this.authorId,
    required this.likeIds,
    required this.commentIds,
    required this.categoryIds,
  }) : postId = postId ?? const Uuid().v4();

  // Create an initial constructor
  const PostHiveModel.initial()
      : postId = '',
        caption = '',
        price = '',
        description = '',
        location = '',
        image = '',
        authorId = '',
        likeIds = const [],
        commentIds = const [],
        categoryIds = const [];

  // Create From Entity
  factory PostHiveModel.fromEntity(PostEntity entity) {
    return PostHiveModel(
      postId: entity.postId,
      caption: entity.caption,
      price: entity.price,
      description: entity.description,
      location: entity.location,
      image: entity.image,
      authorId: entity.authorId,
      likeIds: entity.likeIds,
      commentIds: entity.commentIds,
      categoryIds: entity.categoryIds,
    );
  }

  //  Create to Entity
  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      caption: caption,
      price: price,
      description: description,
      location: location,
      image: image,
      authorId: authorId,
      likeIds: likeIds,
      commentIds: commentIds,
      categoryIds: categoryIds,
    );
  }

  @override
  List<Object?> get props => [
        postId,
        caption,
        price,
        description,
        location,
        image,
        authorId,
        likeIds,
        commentIds,
        categoryIds,
      ];
//  create From entity List to model list
  static List<PostEntity> toEntityList(List<PostHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  String toString() {
    return 'PostHiveModel{postId: $postId, caption: $caption, price: $price, description: $description, location: $location, image: $image, authorId: $authorId, likeIds: $likeIds, commentIds: $commentIds, categoryIds: $categoryIds}';
  }
}
