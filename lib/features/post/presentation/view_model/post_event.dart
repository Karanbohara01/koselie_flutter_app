import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class LoadPosts extends PostEvent {}

final class CreatePost extends PostEvent {
  final String caption;
  final String price;
  final String description;
  final String location;
  final String image;
  final String authorId;
  final List<String> likeIds;
  final List<String> commentIds;
  final List<String> categoryIds;

  const CreatePost({
    required this.caption,
    required this.price,
    required this.description,
    required this.location,
    required this.image,
    required this.authorId,
    this.likeIds = const [], // Provide default values for optional lists
    this.commentIds = const [],
    this.categoryIds = const [],
  });

  @override
  List<Object> get props => [
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
}

final class DeletePost extends PostEvent {
  final String postId;
  const DeletePost(String s, {required this.postId});
  @override
  List<Object> get props => [postId];
}
