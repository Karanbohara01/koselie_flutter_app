// import 'package:equatable/equatable.dart';

// class AuthEntity extends Equatable {
//   final String? userId;
//   final String username;
//   final String email;
//   final String? password;
//   final String? image;
//   final String? profilePicture;
//   final String? role;
//   final String? bio;
//   final List<String>? followers;
//   final List<String>? following;
//   final List<String>? posts;
//   final List<String>? bookmarks;
//   final bool? isVerified;
//   final String? verificationToken;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   const AuthEntity({
//     required this.username,
//     required this.email,
//     this.password,
//     this.userId,
//     this.image,
//     this.profilePicture,
//     this.role,
//     this.bio,
//     this.followers,
//     this.following,
//     this.posts,
//     this.bookmarks,
//     this.isVerified,
//     this.verificationToken,
//     this.createdAt,
//     this.updatedAt,
//   });

//   // ✅ **From JSON method with null checks**
//   factory AuthEntity.fromJson(Map<String, dynamic> json) {
//     return AuthEntity(
//       userId: json['_id'] as String?,
//       username: json['username'] ?? "Unknown User",
//       email: json['email'] ?? "No Email",
//       image: json['image'] as String?,
//       profilePicture: json['profilePicture'] as String?,
//       role: json['role'] as String?,
//       bio: json['bio'] as String?,
//       followers: (json['followers'] != null)
//           ? List<String>.from(json['followers'])
//           : null,
//       following: (json['following'] != null)
//           ? List<String>.from(json['following'])
//           : null,
//       posts: (json['posts'] != null) ? List<String>.from(json['posts']) : null,
//       bookmarks: (json['bookmarks'] != null)
//           ? List<String>.from(json['bookmarks'])
//           : null,
//       isVerified: json['isVerified'] as bool?,
//       verificationToken: json['verificationToken'] as String?,
//       createdAt:
//           json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
//       updatedAt:
//           json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
//     );
//   }

//   /// ✅ **`copyWith` Method for Partial Updates**
//   AuthEntity copyWith({
//     String? userId,
//     String? username,
//     String? email,
//     String? password,
//     String? image,
//     String? profilePicture,
//     String? role,
//     String? bio,
//     List<String>? followers,
//     List<String>? following,
//     List<String>? posts,
//     List<String>? bookmarks,
//     bool? isVerified,
//     String? verificationToken,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return AuthEntity(
//       userId: userId ?? this.userId,
//       username: username ?? this.username,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       image: image ?? this.image,
//       profilePicture: profilePicture ?? this.profilePicture,
//       role: role ?? this.role,
//       bio: bio ?? this.bio,
//       followers: followers ?? this.followers,
//       following: following ?? this.following,
//       posts: posts ?? this.posts,
//       bookmarks: bookmarks ?? this.bookmarks,
//       isVerified: isVerified ?? this.isVerified,
//       verificationToken: verificationToken ?? this.verificationToken,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? DateTime.now(), // ✅ Auto-update timestamp
//     );
//   }

//   // ✅ **Empty constructor for default values**
//   const AuthEntity.empty()
//       : userId = null,
//         email = "",
//         password = null,
//         image = null,
//         profilePicture = null,
//         username = "",
//         role = null,
//         bio = null,
//         followers = null,
//         following = null,
//         posts = null,
//         bookmarks = null,
//         isVerified = null,
//         verificationToken = null,
//         createdAt = null,
//         updatedAt = null;

//   @override
//   List<Object?> get props => [
//         userId,
//         username,
//         email,
//         password,
//         image,
//         profilePicture,
//         role,
//         bio,
//         followers,
//         following,
//         posts,
//         bookmarks,
//         isVerified,
//         verificationToken,
//         createdAt,
//         updatedAt,
//       ];
// }

import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String username;
  final String email;
  final String? password;
  final String? image;
  final String? profilePicture;
  final String? role;
  final String? bio;
  final List<String> followers; // Default empty list
  final List<String> following; // Default empty list
  final List<String> posts; // Default empty list
  final List<String> bookmarks; // Default empty list
  final bool isVerified; // Default false
  final String? verificationToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AuthEntity({
    required this.username,
    required this.email,
    this.password,
    this.userId,
    this.image,
    this.profilePicture,
    this.role,
    this.bio,
    this.followers = const [],
    this.following = const [],
    this.posts = const [],
    this.bookmarks = const [],
    this.isVerified = false,
    this.verificationToken,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      userId: json['_id'] as String?,
      username: json['username'] ?? "Unknown User",
      email: json['email'] ?? "No Email",
      image: json['image'] as String?,
      profilePicture: json['profilePicture'] as String?,
      role: json['role'] as String?,
      bio: json['bio'] as String?,
      followers: (json['followers'] is List)
          ? List<String>.from(json['followers'])
          : [],
      following: (json['following'] is List)
          ? List<String>.from(json['following'])
          : [],
      posts: (json['posts'] is List) ? List<String>.from(json['posts']) : [],
      bookmarks: (json['bookmarks'] is List)
          ? List<String>.from(json['bookmarks'])
          : [],
      isVerified: json['isVerified'] ?? false,
      verificationToken: json['verificationToken'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  AuthEntity copyWith({
    String? userId,
    String? username,
    String? email,
    String? password,
    String? image,
    String? profilePicture,
    String? role,
    String? bio,
    List<String>? followers,
    List<String>? following,
    List<String>? posts,
    List<String>? bookmarks,
    bool? isVerified,
    String? verificationToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AuthEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
      profilePicture: profilePicture ?? this.profilePicture,
      role: role ?? this.role,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      bookmarks: bookmarks ?? this.bookmarks,
      isVerified: isVerified ?? this.isVerified,
      verificationToken: verificationToken ?? this.verificationToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(), // Auto-update timestamp
    );
  }

  const AuthEntity.empty()
      : userId = null,
        email = "",
        password = null,
        image = null,
        profilePicture = null,
        username = "",
        role = null,
        bio = null,
        followers = const [],
        following = const [],
        posts = const [],
        bookmarks = const [],
        isVerified = false,
        verificationToken = null,
        createdAt = null,
        updatedAt = null;

  @override
  List<Object?> get props => [
        userId,
        username,
        email,
        password,
        image,
        profilePicture,
        role,
        bio,
        followers,
        following,
        posts,
        bookmarks,
        isVerified,
        verificationToken,
        createdAt,
        updatedAt,
      ];
}
