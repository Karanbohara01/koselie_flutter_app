import 'package:dio/dio.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/chat/data/data_source/chat_data_source.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';

class ChatRemoteDataSource implements IChatDataSource {
  final Dio _dio;

  ChatRemoteDataSource(this._dio);

  /// ✅ **Send Message and Immediately Fetch Updated Messages**
  @override
  Future<List<MessageEntity>> sendMessage(
      String token, MessageEntity message, String receiverId) async {
    try {
      await _dio.post(
        "${ApiEndpoints.sendMessage}/$receiverId",
        data: {
          "message": message.message, // ✅ Only send text, backend gets senderId
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

      // ✅ After sending, immediately fetch updated messages
      return await getMessages(token, message.senderId, receiverId);
    } on DioException catch (e) {
      throw Exception(
          "❌ Error sending message: ${e.response?.data ?? e.toString()}");
    }
  }

  /// ✅ **Fetch Messages Between Logged-in User & Selected User**
  @override
  Future<List<MessageEntity>> getMessages(
      String token, String senderId, String receiverId) async {
    try {
      Response response = await _dio.get(
        "${ApiEndpoints.getMessages}/$receiverId", // ✅ Fetch full conversation
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['messages'] ?? [];

        // ✅ Parse JSON into List<MessageEntity>
        return data.map((json) {
          return MessageEntity(
            messageId: json['_id'] ?? "", // Prevent nulls
            senderId: json['senderId'] ?? "", // Fix senderId issues
            receiverId: json['receiverId'] ?? "", // Fix receiverId issues
            message: json['message'] ?? "[No message]", // Handle missing text
            createdAt: DateTime.tryParse(json['createdAt'] ?? "") ??
                DateTime.now(), // Fix null date
          );
        }).toList();
      } else {
        throw Exception(
            "❌ Failed to fetch messages: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("❌ DioException: ${e.response?.data ?? e.toString()}");
    }
  }

  /// ✅ **Delete Message**
  @override
  Future<void> deleteMessage(String token, String messageId) async {
    try {
      Response response = await _dio.delete(
        "http://10.0.2.2:8000/api/v1/message/messages/$messageId",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
            "❌ Failed to delete message: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("❌ DioException: ${e.response?.data ?? e.toString()}");
    }
  }
}
