// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      userId: json['_id'] as String?,
      image: json['image'] as String?,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      profilePicture: json['profilePicture'] as String?,
      role: json['role'] as String?,
      bio: json['bio'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      posts:
          (json['posts'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bookmarks: (json['bookmarks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isVerified: json['isVerified'] as bool?,
      verificationToken: json['verificationToken'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'profilePicture': instance.profilePicture,
      'role': instance.role,
      'bio': instance.bio,
      'followers': instance.followers,
      'following': instance.following,
      'posts': instance.posts,
      'bookmarks': instance.bookmarks,
      'isVerified': instance.isVerified,
      'verificationToken': instance.verificationToken,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
