// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsHiveModelAdapter extends TypeAdapter<PostsHiveModel> {
  @override
  final int typeId = 1;

  @override
  PostsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostsHiveModel(
      postId: fields[0] as String?,
      caption: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as String,
      location: fields[4] as String,
      category: fields[6] as CategoryHiveModel,
      image: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PostsHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.postId)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
