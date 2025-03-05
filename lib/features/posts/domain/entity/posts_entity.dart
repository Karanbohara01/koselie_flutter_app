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
  final String? authorId; // Post author's ID
  final String? username; // Post author's ID
  // ✅ Added Author Information
  final String? author; // Post author's username
  final String? profilePicture; // Post author's profile picture URL

  // ✅ Added Likes & Comments
  final List<String>? comments; // List of comment IDs
  final List<String>? likes; // List of user IDs who liked the post

  /// Default empty constructor with placeholder values.
  const PostsEntity.empty()
      : postId = '_empty.postId',
        caption = '_empty.caption',
        location = '_empty.location',
        price = '_empty.price',
        description = '_empty.description',
        image = '_empty.image',
        username = '_empty.username',
        category = const CategoryEntity.empty(), // Ensuring proper type.
        authorId = '_empty.authorId',
        author = '_empty.author',
        profilePicture = '_empty.profilePicture',
        comments = const [],
        likes = const [];

  /// Main constructor for creating a [PostsEntity].
  const PostsEntity(
      {this.postId,
      required this.caption,
      required this.description,
      required this.price,
      required this.location,
      this.image,
      required this.category,
      this.comments,
      this.likes,
      this.author,
      this.username,
      this.authorId,
      this.profilePicture});

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
      username: json['username'] as String?,
      category: categoryEntity, // Using the properly parsed category
      // ✅ Author Parsing (Ensure null safety)
      authorId: json['author']?['_id'] as String?,
      author: json['author']?['username'] as String?,
      profilePicture: json['author']?['image'] as String?,

      // ✅ Comments & Likes Handling
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => comment.toString())
          .toList(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((like) => like.toString())
          .toList(),
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
      'author': {
        '_id': authorId,
        'username': author,
        'image': profilePicture,
      },
      'comments': comments ?? [],
      'likes': likes ?? [],
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
    String? authorId,
    String? author,
    String? profilePicture,
    List<String>? comments,
    List<String>? likes,
  }) {
    return PostsEntity(
      postId: postId ?? this.postId,
      caption: caption ?? this.caption,
      description: description ?? this.description,
      price: price ?? this.price,
      location: location ?? this.location,
      image: image ?? this.image,
      category: category ?? this.category,
      authorId: authorId ?? this.authorId,
      author: author ?? this.author,
      profilePicture: profilePicture ?? this.profilePicture,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
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
        authorId,
        author,
        profilePicture,
        comments,
        likes,
      ];
}
