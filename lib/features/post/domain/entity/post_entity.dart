import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String caption;
  final String price;
  final String description;
  final String location;
  final String image;
  final String authorId;
  final List<String> likeIds;
  final List<String> commentIds; // List of Comment IDs
  final List<String> categoryIds; // List of Category IDs

  const PostEntity({
    this.postId,
    required this.caption,
    required this.price,
    required this.description,
    required this.location,
    required this.image,
    required this.authorId,
    required this.likeIds,
    required this.commentIds,
    required this.categoryIds,
  });

  // Empty Constructor - PROBLEM!  This will cause Equatable to malfunction
  const PostEntity.empty()
      : postId = '_empty.postId',
        caption = '_empty.caption',
        price = '_empty.price',
        location = '_empty.location',
        description = '_empty.description',
        image = '_empty.image',
        authorId = '_empty.authorId',
        likeIds = const [],
        commentIds = const [],
        categoryIds = const [];

  @override
  List<Object?> get props => [
        postId,
        caption,
        price,
        location,
        description,
        image,
        authorId,
        likeIds,
        commentIds,
        categoryIds,
      ];
}
