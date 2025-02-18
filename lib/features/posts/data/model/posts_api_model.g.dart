// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsApiModel _$PostsApiModelFromJson(Map<String, dynamic> json) =>
    PostsApiModel(
      postId: json['_id'] as String?,
      caption: json['caption'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      location: json['location'] as String,
      image: json['image'] as String?,
      category:
          CategoryApiModel.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostsApiModelToJson(PostsApiModel instance) =>
    <String, dynamic>{
      '_id': instance.postId,
      'caption': instance.caption,
      'description': instance.description,
      'price': instance.price,
      'location': instance.location,
      'image': instance.image,
      'category': instance.category,
    };
