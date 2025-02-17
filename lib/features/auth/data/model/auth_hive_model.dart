// import 'package:equatable/equatable.dart';
// import 'package:hive/hive.dart';
// import 'package:koselie/app/constants/hive_table_constant.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:uuid/uuid.dart';

// part 'auth_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.authTableId)
// class AuthHiveModel extends Equatable {
//   @HiveField(0)
//   final String? userId;

//   @HiveField(1)
//   final String username;

//   @HiveField(2)
//   final String email;

//   @HiveField(3)
//   final String? password;

//   // Main Constructor
//   AuthHiveModel({
//     String? userId,
//     required this.email,
//     required this.username,
//     this.password,
//   }) : userId = userId ?? const Uuid().v4();

//   // Initial Constructor
//   // Creates an instance with default empty values

//   const AuthHiveModel.initial()
//       : userId = '',
//         username = '',
//         password = '',
//         email = '';

//   // Convert AuthEntity into Auth Hive Model
//   factory AuthHiveModel.fromEntity(AuthEntity entity) {
//     return AuthHiveModel(
//       userId: entity.userId,
//       email: entity.email,
//       username: entity.username,
//       password: entity.password,
//     );
//   }

//   // Convert AuthHiveModel back to AuthEntity
//   AuthEntity toEntity() {
//     return AuthEntity(
//         userId: userId, username: username, email: email, password: password);
//   }

//   // To entity list
//   static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
//     return entityList
//         .map((entity) => AuthHiveModel.fromEntity(entity))
//         .toList();
//   }

//   @override
//   List<Object?> get props => [userId, username, password, email];
// }

// // complete xa

// import 'package:equatable/equatable.dart';
// import 'package:hive/hive.dart';
// import 'package:koselie/app/constants/hive_table_constant.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:uuid/uuid.dart';

// part 'auth_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.authTableId)
// class AuthHiveModel extends Equatable {
//   @HiveField(0)
//   final String? userId;

//   @HiveField(1)
//   final String username;

//   @HiveField(2)
//   final String email;

//   @HiveField(3)
//   final String? password;

//   @HiveField(4)
//   final String? profilePicture;

//   @HiveField(5)
//   final String? role;

//   @HiveField(6)
//   final String? bio;

//   @HiveField(7)
//   final List<String>? followers;

//   @HiveField(8)
//   final List<String>? following;

//   @HiveField(9)
//   final List<String>? posts;

//   @HiveField(10)
//   final List<String>? bookmarks;

//   @HiveField(11)
//   final bool? isVerified;

//   @HiveField(12)
//   final String? verificationToken;

//   @HiveField(13)
//   final DateTime? createdAt;

//   @HiveField(14)
//   final DateTime? updatedAt;

//   // ✅ **Main Constructor**
//   AuthHiveModel({
//     String? userId,
//     required this.email,
//     required this.username,
//     this.password,
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
//   }) : userId = userId ?? const Uuid().v4();

//   // ✅ **Empty Constructor for Defaults**
//   const AuthHiveModel.initial()
//       : userId = '',
//         username = '',
//         email = '',
//         password = '',
//         profilePicture = null,
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

//   // ✅ **Convert from Entity (for saving to Hive)**
//   factory AuthHiveModel.fromEntity(AuthEntity entity) {
//     return AuthHiveModel(
//       userId: entity.userId,
//       email: entity.email,
//       username: entity.username,
//       password: entity.password,
//       profilePicture: entity.profilePicture,
//       role: entity.role,
//       bio: entity.bio,
//       followers: entity.followers,
//       following: entity.following,
//       posts: entity.posts,
//       bookmarks: entity.bookmarks,
//       isVerified: entity.isVerified,
//       verificationToken: entity.verificationToken,
//       createdAt: entity.createdAt,
//       updatedAt: entity.updatedAt,
//     );
//   }

//   // ✅ **Convert back to Entity (for UI use)**
//   AuthEntity toEntity() {
//     return AuthEntity(
//       userId: userId,
//       username: username,
//       email: email,
//       password: password,
//       profilePicture: profilePicture,
//       role: role,
//       bio: bio,
//       followers: followers,
//       following: following,
//       posts: posts,
//       bookmarks: bookmarks,
//       isVerified: isVerified,
//       verificationToken: verificationToken,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//     );
//   }

//   // ✅ **Convert List of Entities to Hive Models**
//   static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
//     return entityList
//         .map((entity) => AuthHiveModel.fromEntity(entity))
//         .toList();
//   }

//   @override
//   List<Object?> get props => [
//         userId,
//         username,
//         email,
//         password,
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
import 'package:hive/hive.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? password;

  @HiveField(4)
  final String? profilePicture;

  @HiveField(5)
  final String? role;

  @HiveField(6)
  final String? bio;

  @HiveField(7)
  final List<String>? followers;

  @HiveField(8)
  final List<String>? following;

  @HiveField(9)
  final List<String>? posts;

  @HiveField(10)
  final List<String>? bookmarks;

  @HiveField(11)
  final bool? isVerified;

  @HiveField(12)
  final String? verificationToken;

  @HiveField(13)
  final DateTime? createdAt;

  @HiveField(14)
  final DateTime? updatedAt;

  // ✅ **Main Constructor**
  AuthHiveModel({
    String? userId,
    required this.email,
    required this.username,
    this.password,
    this.profilePicture,
    this.role,
    this.bio,
    this.followers,
    this.following,
    this.posts,
    this.bookmarks,
    this.isVerified,
    this.verificationToken,
    this.createdAt,
    this.updatedAt,
  }) : userId = userId ?? const Uuid().v4();

  // ✅ **Empty Constructor for Defaults**
  const AuthHiveModel.initial()
      : userId = '',
        username = '',
        email = '',
        password = '',
        profilePicture = null,
        role = null,
        bio = null,
        followers = null,
        following = null,
        posts = null,
        bookmarks = null,
        isVerified = null,
        verificationToken = null,
        createdAt = null,
        updatedAt = null;

  // ✅ **Convert from Entity (for saving to Hive)**
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      profilePicture: entity.profilePicture,
      role: entity.role,
      bio: entity.bio,
      followers: entity.followers,
      following: entity.following,
      posts: entity.posts,
      bookmarks: entity.bookmarks,
      isVerified: entity.isVerified,
      verificationToken: entity.verificationToken,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // ✅ **Convert back to Entity (for UI use)**
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      username: username,
      email: email,
      password: password,
      profilePicture: profilePicture,
      role: role ?? "User",
      bio: bio ?? "",
      followers: followers ?? [],
      following: following ?? [],
      posts: posts ?? [],
      bookmarks: bookmarks ?? [],
      isVerified: isVerified ?? false,
      verificationToken: verificationToken,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// ✅ **`copyWith` Method for Updating Specific Fields**
  AuthHiveModel copyWith({
    String? userId,
    String? username,
    String? email,
    String? password,
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
    return AuthHiveModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
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
      updatedAt:
          updatedAt ?? DateTime.now(), // ✅ Automatically update timestamp
    );
  }

  // ✅ **Convert List of Entities to Hive Models**
  static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
    return entityList
        .map((entity) => AuthHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        email,
        password,
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
