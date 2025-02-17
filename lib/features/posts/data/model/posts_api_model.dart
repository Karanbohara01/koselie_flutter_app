import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/category/data/model/category_api_model.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';

part 'posts_api_model.g.dart';

@JsonSerializable()
class PostsApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? postId;
  final String caption;
  final String description;
  final String price;
  final String location;
  final String? image;
  final CategoryApiModel category;

  const PostsApiModel({
    this.postId,
    required this.caption,
    required this.description,
    required this.price,
    required this.location,
    this.image,
    required this.category,
  });

  /// Factory constructor for deserializing JSON into `PostsApiModel`
  factory PostsApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostsApiModelFromJson(json);

  /// Method for serializing `PostsApiModel` into JSON
  Map<String, dynamic> toJson() => _$PostsApiModelToJson(this);

  /// Convert API model to domain entity
  PostsEntity toEntity() => PostsEntity(
        postId: postId,
        caption: caption,
        description: description,
        price: price,
        location: location,
        image: image,
        category: category.toEntity(),
      );

  /// Convert domain entity to API model
  factory PostsApiModel.fromEntity(PostsEntity entity) => PostsApiModel(
        postId: entity.postId,
        caption: entity.caption,
        description: entity.description,
        price: entity.price,
        location: entity.location,
        image: entity.image,
        category: CategoryApiModel.fromEntity(entity.category),
      );

  /// Convert a list of API models to a list of entities
  static List<PostsEntity> toEntityList(List<PostsApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// Convert a list of JSON objects to a list of API models
  static List<PostsApiModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => PostsApiModel.fromJson(json)).toList();

  @override
  List<Object?> get props => [
        postId,
        caption,
        description,
        price,
        location,
        image,
        category,
      ];
}
