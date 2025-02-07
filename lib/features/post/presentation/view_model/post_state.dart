import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:koselie/features/post/domain/entity/post_entity.dart';

@immutable
sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostSuccess extends PostState {
  final List<PostEntity> posts;

  const PostSuccess({required this.posts});

  @override
  List<Object?> get props => [posts];
}

final class PostFailure extends PostState {
  final String message;

  const PostFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
