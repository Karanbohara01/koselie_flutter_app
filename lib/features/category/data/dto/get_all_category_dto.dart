import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/category/data/model/category_api_model.dart';

part 'get_all_category_dto.g.dart';

@JsonSerializable()
class GetAllCategoryDTO {
  final bool success;
  final int count;
  final List<CategoryApiModel> data;

  GetAllCategoryDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllCategoryDTOToJson(this);

  factory GetAllCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoryDTOFromJson(json);
}
