// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      messageId: json['_id'] as String?,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      '_id': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
    };
