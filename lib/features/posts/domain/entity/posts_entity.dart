// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';

/// Represents a post entity with details such as caption, price, location, and category.
class PostsEntity extends Equatable {
  final String? postId; // Unique identifier for the post
  final String caption; // Caption or title of the post
  final String description; // Description or details of the post
  final String price; // Price of the post item
  final String location; // Location associated with the post
  final String? image; // Image URL or file path
  final CategoryEntity category; // Associated category of the post

  /// Default empty constructor with placeholder values.
  const PostsEntity.empty()
      : postId = '_empty.postId',
        caption = '_empty.caption',
        location = '_empty.location',
        price = '_empty.price',
        description = '_empty.description',
        image = '_empty.image',
        category = const CategoryEntity.empty(); // Ensuring proper type.

  /// Main constructor for creating a [PostsEntity].
  const PostsEntity({
    this.postId,
    required this.caption,
    required this.description,
    required this.price,
    required this.location,
    this.image,
    required this.category,
  });

  factory PostsEntity.fromJson(Map<String, dynamic> json) {
    var categoryJson = json['category'];

    // Check if category is a List and handle empty cases
    CategoryEntity categoryEntity = const CategoryEntity.empty();

    if (categoryJson is List && categoryJson.isNotEmpty) {
      // Use the first item in the category list
      categoryEntity = CategoryEntity.fromJson(categoryJson[0]);
    } else if (categoryJson is Map) {
      // If category is already a single map, handle directly
      categoryEntity = CategoryEntity.fromJson(categoryJson);
    }

    return PostsEntity(
      postId: json['_id'] as String?,
      caption: json['caption'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      location: json['location'] as String,
      image: json['image'] as String?,
      category: categoryEntity, // Using the properly parsed category
    );
  }

  /// Converts a [PostsEntity] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'caption': caption,
      'description': description,
      'price': price,
      'location': location,
      'image': image,
      'category': category.toJson(),
    };
  }

  /// Creates a copy of the current instance with new values.
  PostsEntity copyWith({
    String? postId,
    String? caption,
    String? description,
    String? price,
    String? location,
    String? image,
    CategoryEntity? category,
  }) {
    return PostsEntity(
      postId: postId ?? this.postId,
      caption: caption ?? this.caption,
      description: description ?? this.description,
      price: price ?? this.price,
      location: location ?? this.location,
      image: image ?? this.image,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        postId,
        caption,
        location,
        price,
        description,
        image,
        category,
      ];
}

// import 'package:equatable/equatable.dart';
// import 'package:koselie/features/category/domain/entity/category_entity.dart';
// import 'package:koselie/features/posts/domain/entity/comment_entity.dart';

// /// Represents a post entity with details such as caption, price, location, and category.
// class PostsEntity extends Equatable {
//   final String? postId;
//   final String caption;
//   final String description;
//   final String price;
//   final String location;
//   final String? image;
//   final CategoryEntity category;
//   final List<String> likes; // List of user IDs who liked the post
//   final List<CommentEntity> comments; // List of comments

//   /// Default empty constructor with placeholder values.
//   const PostsEntity.empty()
//       : postId = '_empty.postId',
//         caption = '_empty.caption',
//         location = '_empty.location',
//         price = '_empty.price',
//         description = '_empty.description',
//         image = '_empty.image',
//         category = const CategoryEntity.empty(),
//         likes = const [],
//         comments = const [];

//   /// Main constructor for creating a [PostsEntity].
//   const PostsEntity({
//     this.postId,
//     required this.caption,
//     required this.description,
//     required this.price,
//     required this.location,
//     this.image,
//     required this.category,
//     required this.likes,
//     required this.comments,
//   });

//   factory PostsEntity.fromJson(Map<String, dynamic> json) {
//     var categoryJson = json['category'];
//     CategoryEntity categoryEntity = const CategoryEntity.empty();

//     if (categoryJson is List && categoryJson.isNotEmpty) {
//       categoryEntity = CategoryEntity.fromJson(categoryJson[0]);
//     } else if (categoryJson is Map) {
//       categoryEntity = CategoryEntity.fromJson(categoryJson);
//     }

//     return PostsEntity(
//       postId: json['_id'] as String?,
//       caption: json['caption'] as String,
//       description: json['description'] as String,
//       price: json['price'] as String,
//       location: json['location'] as String,
//       image: json['image'] as String?,
//       category: categoryEntity,
//       likes: List<String>.from(json['likes'] ?? []), // Extract user IDs
//       comments: (json['comments'] as List?)
//               ?.map((c) => CommentEntity.fromJson(c))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'postId': postId,
//       'caption': caption,
//       'description': description,
//       'price': price,
//       'location': location,
//       'image': image,
//       'category': category.toJson(),
//       'likes': likes,
//       'comments': comments.map((c) => c.toJson()).toList(),
//     };
//   }

//   PostsEntity copyWith({
//     String? postId,
//     String? caption,
//     String? description,
//     String? price,
//     String? location,
//     String? image,
//     CategoryEntity? category,
//     List<String>? likes,
//     List<CommentEntity>? comments,
//   }) {
//     return PostsEntity(
//       postId: postId ?? this.postId,
//       caption: caption ?? this.caption,
//       description: description ?? this.description,
//       price: price ?? this.price,
//       location: location ?? this.location,
//       image: image ?? this.image,
//       category: category ?? this.category,
//       likes: likes ?? this.likes,
//       comments: comments ?? this.comments,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         postId,
//         caption,
//         location,
//         price,
//         description,
//         image,
//         category,
//         likes,
//         comments,
//       ];
// }
