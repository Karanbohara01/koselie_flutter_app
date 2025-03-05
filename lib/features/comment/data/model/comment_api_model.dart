import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';

part 'comment_api_model.g.dart'; // 🔥 Auto-generated file

@JsonSerializable(explicitToJson: true)
class CommentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? commentId;
  final String text;
  final String authorId;
  final String postId;
  final String authorUsername;
  final String profilePicture;

  const CommentApiModel({
    this.commentId,
    required this.text,
    required this.authorId,
    required this.postId,
    required this.authorUsername,
    required this.profilePicture,
  });

  // Empty Constructor
  const CommentApiModel.empty()
      : commentId = '',
        text = '',
        authorId = '',
        postId = '',
        authorUsername = '',
        profilePicture = '';

  // ✅ Auto-generate from JSON
  factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$CommentApiModelFromJson(json);

  // ✅ Auto-generate to JSON
  Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);

  // Convert API Model to Domain Entity
  CommentEntity toEntity() => CommentEntity(
        commentId: commentId,
        text: text,
        authorId: authorId,
        postId: postId,
        authorUsername: authorUsername,
        profilePicture: profilePicture,
      );

  // Convert Domain Entity to API Model
  static CommentApiModel fromEntity(CommentEntity entity) => CommentApiModel(
        commentId: entity.commentId,
        text: entity.text,
        authorId: entity.authorId,
        postId: entity.postId,
        authorUsername: entity.authorUsername,
        profilePicture: entity.profilePicture,
      );

  // Convert API List to Entity List
  static List<CommentEntity> toEntityList(List<CommentApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        commentId,
        text,
        authorId,
        postId,
        authorUsername,
        profilePicture,
      ];
}
