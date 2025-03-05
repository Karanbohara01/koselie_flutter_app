// import 'package:equatable/equatable.dart';

// class CommentEntity extends Equatable {
//   final String? commentId;
//   final String text;
//   final String authorId;
//   final String postId;
//   final String authorUsername;
//   final String profilePicture;

//   const CommentEntity({
//     this.commentId,
//     required this.text,
//     required this.authorId,
//     required this.postId,
//     required this.authorUsername,
//     required this.profilePicture,
//   });

//   // Empty constructor
//   const CommentEntity.empty()
//       : commentId = '_empty.commentId',
//         text = '_empty.text',
//         authorId = '_empty.authorId',
//         postId = '_empty.postId',
//         authorUsername = '_empty.authorUsername',
//         profilePicture = '_empty.profilePicture';

//   @override
//   List<Object?> get props =>
//       [commentId, text, authorId, postId, authorUsername, profilePicture];
//   factory CommentEntity.fromJson(Map<String, dynamic> json) {
//     return CommentEntity(
//       commentId: json['_id'] ?? '', // ✅ Handle missing `_id`
//       text: json['text'] ?? 'No text', // ✅ Handle missing text
//       postId: json['post'] ?? '', // ✅ Handle missing postId
//       authorId: json['author']?['_id'] ?? '', // ✅ Handle nested authorId
//       authorUsername:
//           json['author']?['username'] ?? 'Unknown', // ✅ Handle missing username
//       profilePicture: json['author']?['profilePicture'] ??
//           '', // ✅ Handle missing profile picture
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'commentId': commentId,
//       'text': text,
//       'authorId': authorId,
//       'postId': postId,
//       'authorUsername': authorUsername,
//       'profilePicture': profilePicture,
//     };
//   }
// }

import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? commentId;
  final String text;
  final String authorId;
  final String postId;
  final String authorUsername;
  final String profilePicture;
  final String? image;

  const CommentEntity({
    this.commentId,
    required this.text,
    required this.authorId,
    required this.postId,
    required this.authorUsername,
    required this.profilePicture,
    this.image,
  });

  // Empty constructor
  const CommentEntity.empty()
      : commentId = null,
        text = '',
        authorId = '',
        postId = '',
        authorUsername = '',
        profilePicture = '',
        image = '';

  @override
  List<Object?> get props => [
        commentId,
        text,
        authorId,
        postId,
        authorUsername,
        profilePicture,
        image
      ];

  // Factory method for JSON deserialization
  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
      commentId: json['_id'], // No need for default since it's nullable
      text: json['text'] ?? 'No text provided',
      postId: json['post'] ?? '',
      authorId: json['author']?['_id'] ?? '',
      authorUsername: json['author']?['username'] ?? 'Unknown',
      profilePicture: json['author']?['profilePicture'] ?? '',
      image: json['author']?['image'] ?? '',
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      '_id': commentId,
      'text': text,
      'post': postId,
      'author': {
        '_id': authorId,
        'username': authorUsername,
        'profilePicture': profilePicture,
        'image': image,
      },
    };
  }
}
