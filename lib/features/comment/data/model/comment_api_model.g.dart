// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentApiModel _$CommentApiModelFromJson(Map<String, dynamic> json) =>
    CommentApiModel(
      commentId: json['_id'] as String?,
      text: json['text'] as String,
      authorId: json['authorId'] as String,
      postId: json['postId'] as String,
      authorUsername: json['authorUsername'] as String,
      profilePicture: json['profilePicture'] as String,
    );

Map<String, dynamic> _$CommentApiModelToJson(CommentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.commentId,
      'text': instance.text,
      'authorId': instance.authorId,
      'postId': instance.postId,
      'authorUsername': instance.authorUsername,
      'profilePicture': instance.profilePicture,
    };
