// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveModelAdapter extends TypeAdapter<PostHiveModel> {
  @override
  final int typeId = 1;

  @override
  PostHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHiveModel(
      postId: fields[0] as String?,
      caption: fields[1] as String,
      price: fields[2] as String,
      description: fields[3] as String,
      location: fields[4] as String,
      image: fields[5] as String,
      authorId: fields[6] as String,
      likeIds: (fields[7] as List).cast<String>(),
      commentIds: (fields[8] as List).cast<String>(),
      categoryIds: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.postId)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.authorId)
      ..writeByte(7)
      ..write(obj.likeIds)
      ..writeByte(8)
      ..write(obj.commentIds)
      ..writeByte(9)
      ..write(obj.categoryIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
