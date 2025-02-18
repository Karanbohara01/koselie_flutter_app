import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? userId;
  final String username;
  final String email;
  final String? password;
  final String? image;
  final String? profilePicture;
  final String? role;
  final String? bio;
  final List<String>? followers;
  final List<String>? following;
  final List<String>? posts;
  final List<String>? bookmarks;
  final bool? isVerified;
  final String? verificationToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AuthApiModel({
    this.userId,
    this.image,
    required this.username,
    required this.email,
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
  });

  /// ✅ **Factory constructor to parse JSON response**
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  /// ✅ **Method to convert object to JSON**
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  /// ✅ **Convert to Entity**
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      image: image,
      email: email,
      username: username,
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

  /// ✅ **Convert from Entity**
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      userId: entity.userId,
      image: entity.image,
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

  /// ✅ **`copyWith` Method for Updating Specific Fields**
  AuthApiModel copyWith({
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
    return AuthApiModel(
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
      updatedAt:
          updatedAt ?? DateTime.now(), // ✅ Automatically update timestamp
    );
  }

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
