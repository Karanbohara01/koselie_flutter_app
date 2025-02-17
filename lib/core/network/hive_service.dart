// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:koselie/app/constants/hive_table_constant.dart';
// import 'package:koselie/features/auth/data/model/auth_hive_model.dart';
// import 'package:koselie/features/category/data/model/category_hive_model.dart';
// import 'package:koselie/features/posts/data/model/posts_hive_model.dart';
// import 'package:path_provider/path_provider.dart';

// class HiveService {
//   static Future<void> init() async {
//     // Initialize the database
//     var directory = await getApplicationDocumentsDirectory();
//     var path = '${directory.path}koselie_app.db';

//     Hive.init(path);

//     // Register Adapters

//     Hive.registerAdapter(AuthHiveModelAdapter());
//     // Hive.registerAdapter(PostHiveModelAdapter());
//     Hive.registerAdapter(CategoryHiveModelAdapter());
//   }

//   //  Categories Queries

//   Future<void> createCategory(CategoryHiveModel category) async {
//     var box =
//         await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
//     await box.put(category.categoryId, category);
//   }

//   Future<void> deleteCategory(String categoryId) async {
//     var box =
//         await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
//     await box.delete(categoryId);
//   }

//   Future<List<CategoryHiveModel>> getAllCategories() async {
//     // Sort by BatchName
//     var box =
//         await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
//     return box.values.toList()..sort((a, b) => a.name.compareTo(b.name));
//   }

//   //  Post Queries

//   Future<void> createPost(PostsHiveModel post) async {
//     var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
//     await box.put(post.postId, post);
//   }

//   Future<void> deletePost(String postId) async {
//     var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
//     await box.delete(postId);
//   }

//   Future<List<PostsHiveModel>> getAllPosts() async {
//     var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
//     final posts = box.values.toList();
//     await box.close();
//     return posts;
//   }

//   // Auth Queries
//   Future<void> registerUser(AuthHiveModel auth) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
//     await box.put(auth.userId, auth);
//   }

//   Future<void> deleteUser(String userId) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
//     await box.delete(userId);
//   }

//   Future<List<AuthHiveModel>> getAllUsers() async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
//     return box.values.toList();
//   }

//   // Login using username and password
//   Future<AuthHiveModel?> loginUser(String username, String password) async {
//     // var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//     // var auth = box.values.firstWhere(
//     //     (element) =>
//     //         element.username == username && element.password == password,
//     //     orElse: () => AuthHiveModel.initial());
//     // return auth;

//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
//     var user = box.values.firstWhere((element) =>
//         element.username == username && element.password == password);
//     box.close();
//     return user;
//   }

//   Future<void> clearAll() async {
//     await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
//   }

//   // Clear Student Box
//   Future<void> clearUserBox() async {
//     await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
//   }

//   Future<void> close() async {
//     await Hive.close();
//   }
// }

import 'package:hive_flutter/hive_flutter.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';
import 'package:koselie/features/auth/data/model/auth_hive_model.dart';
import 'package:koselie/features/category/data/model/category_hive_model.dart';
import 'package:koselie/features/posts/data/model/posts_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  /// ✅ Initialize Hive Database
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/koselie_app.db';
    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    // Hive.registerAdapter(MessageHiveModelAdapter());
    // Hive.registerAdapter(ConversationHiveModelAdapter());
    Hive.registerAdapter(CategoryHiveModelAdapter());
    Hive.registerAdapter(PostsHiveModelAdapter());
  }

  // =====================
  // ✅ Conversation Queries
  // =====================

  // Future<void> createConversation(ConversationHiveModel conversation) async {
  //   var box = await Hive.openBox<ConversationHiveModel>(
  //       HiveTableConstant.conversationBox);
  //   await box.put(conversation.conversationId, conversation);
  // }

  // Future<void> deleteConversation(String conversationId) async {
  //   var box = await Hive.openBox<ConversationHiveModel>(
  //       HiveTableConstant.conversationBox);
  //   await box.delete(conversationId);
  // }

  // Future<List<ConversationHiveModel>> getConversations() async {
  //   var box = await Hive.openBox<ConversationHiveModel>(
  //       HiveTableConstant.conversationBox);
  //   return box.values.toList();
  // }

  // Future<ConversationHiveModel?> getConversationById(
  //     String conversationId) async {
  //   var box = await Hive.openBox<ConversationHiveModel>(
  //       HiveTableConstant.conversationBox);
  //   return box.get(conversationId);
  // }

  // =====================
  // // ✅ Message Queries
  // // =====================

  // Future<void> saveMessage(MessageHiveModel message) async {
  //   var box =
  //       await Hive.openBox<MessageHiveModel>(HiveTableConstant.messageBox);
  //   await box.put(message.messageId, message);
  // }

  // Future<List<MessageHiveModel>> getMessages(String conversationId) async {
  //   var box =
  //       await Hive.openBox<MessageHiveModel>(HiveTableConstant.messageBox);
  //   return box.values
  //       .where((message) => message.conversationId == conversationId)
  //       .toList();
  // }

  // Future<void> deleteMessage(String messageId) async {
  //   var box =
  //       await Hive.openBox<MessageHiveModel>(HiveTableConstant.messageBox);
  //   await box.delete(messageId);
  // }

  // =====================
  // ✅ Category Queries
  // =====================

  Future<void> createCategory(CategoryHiveModel category) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.put(category.categoryId, category);
  }

  Future<void> deleteCategory(String categoryId) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.delete(categoryId);
  }

  Future<List<CategoryHiveModel>> getAllCategories() async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    return box.values.toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  // =====================
  // ✅ Post Queries
  // =====================

  Future<void> createPost(PostsHiveModel post) async {
    var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
    await box.put(post.postId, post);
  }

  Future<void> deletePost(String postId) async {
    var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
    await box.delete(postId);
  }

  Future<List<PostsHiveModel>> getAllPosts() async {
    var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
    return box.values.toList();
  }

  // =====================
  // ✅ Auth Queries
  // =====================

  Future<void> registerUser(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteUser(String userId) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(userId);
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  Future<AuthHiveModel?> loginUser(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) =>
            element.username == username && element.password == password,
        orElse: () => const AuthHiveModel.initial());
    return user;
  }

  // =====================
  // ✅ Utility Functions
  // =====================

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.messageBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.conversationBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.categoryBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.postBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
