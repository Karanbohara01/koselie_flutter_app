import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';

part 'post_hive_model.g.dart'; // Required for Hive

@HiveType(typeId: HiveTableConstant.postTableId)
class PostHiveModel extends Equatable {
  @HiveField(0)
  final String? postId;

  @HiveField(1)
  final String caption;

  @HiveField(2)
  final String price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final String authorId;

  @HiveField(7)
  final List<String> likeIds;

  @HiveField(8)
  final List<String> commentIds;

  @HiveField(9)
  final List<String> categoryIds;

  const PostHiveModel({
    // Make constructor const
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

  @override
  List<Object?> get props => [
        postId,
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
