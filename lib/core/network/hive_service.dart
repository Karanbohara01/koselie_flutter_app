// //++++++++++++++++++++++++++++++++++++++++++++
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:koselie/app/constants/hive_table_constant.dart';
// import 'package:koselie/features/auth/data/model/auth_hive_model.dart';
// import 'package:koselie/features/category/data/model/category_hive_model.dart';
// import 'package:koselie/features/posts/data/model/posts_hive_model.dart';
// import 'package:path_provider/path_provider.dart';

// class HiveService {
//   /// ✅ Initialize Hive Database
//   static Future<void> init() async {
//     var directory = await getApplicationDocumentsDirectory();
//     var path = '${directory.path}/koselie_app.db';
//     Hive.init(path);

//     // Register Adapters
//     Hive.registerAdapter(AuthHiveModelAdapter());
//     Hive.registerAdapter(CategoryHiveModelAdapter());
//     Hive.registerAdapter(PostsHiveModelAdapter());
//   }

//   // =====================
//   // ✅ Post Queries
//   // =====================

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
//     return box.values.toList();
//   }

//   /// ✅ **New Method: Clear All Cached Posts**
//   Future<void> clearPosts() async {
//     var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
//     await box.clear(); // ✅ This clears all cached posts in Hive
//   }

//   // =====================
//   // ✅ Auth Queries
//   // =====================

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

//   Future<AuthHiveModel?> loginUser(String username, String password) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
//     var user = box.values.firstWhere(
//         (element) =>
//             element.username == username && element.password == password,
//         orElse: () => const AuthHiveModel.initial());
//     return user;
//   }

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
//     var box =
//         await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
//     return box.values.toList()..sort((a, b) => a.name.compareTo(b.name));
//   }

//   // =====================
//   // ✅ Utility Functions
//   // =====================

//   Future<void> clearAll() async {
//     await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
//     await Hive.deleteBoxFromDisk(HiveTableConstant.categoryBox);
//     await Hive.deleteBoxFromDisk(HiveTableConstant.postBox);
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
  // Singleton instance
  static final HiveService _instance = HiveService._internal();

  factory HiveService() => _instance;

  HiveService._internal();

  /// ✅ Initialize Hive Database
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/koselie_app.db';
    await Hive.initFlutter(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(CategoryHiveModelAdapter());
    Hive.registerAdapter(PostsHiveModelAdapter());
  }

  Future<void> logDatabasePath() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/koselie_app.db';
    print('Hive database path: $path');
  }

  // =====================
  // ✅ Post Queries
  // =====================

  Future<void> createPost(PostsHiveModel post) async {
    try {
      var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
      await box.put(post.postId, post);
    } catch (e) {
      print("❌ Error creating post: $e");
      throw Exception("Failed to create post: $e");
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
      await box.delete(postId);
    } catch (e) {
      print("❌ Error deleting post: $e");
      throw Exception("Failed to delete post: $e");
    }
  }

  Future<List<PostsHiveModel>> getAllPosts() async {
    try {
      var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
      return box.values.toList();
    } catch (e) {
      print("❌ Error fetching posts: $e");
      throw Exception("Failed to fetch posts: $e");
    }
  }

  /// ✅ **New Method: Clear All Cached Posts**
  Future<void> clearPosts() async {
    try {
      var box = await Hive.openBox<PostsHiveModel>(HiveTableConstant.postBox);
      await box.clear(); // ✅ This clears all cached posts in Hive
    } catch (e) {
      print("❌ Error clearing posts: $e");
      throw Exception("Failed to clear posts: $e");
    }
  }

  // =====================
  // ✅ Auth Queries
  // =====================

  Future<void> registerUser(AuthHiveModel auth) async {
    try {
      var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
      await box.put(auth.userId, auth);
    } catch (e) {
      print("❌ Error registering user: $e");
      throw Exception("Failed to register user: $e");
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
      await box.delete(userId);
    } catch (e) {
      print("❌ Error deleting user: $e");
      throw Exception("Failed to delete user: $e");
    }
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    try {
      var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
      return box.values.toList();
    } catch (e) {
      print("❌ Error fetching users: $e");
      throw Exception("Failed to fetch users: $e");
    }
  }

  Future<AuthHiveModel?> loginUser(String username, String password) async {
    try {
      var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
      var user = box.values.firstWhere(
          (element) =>
              element.username == username && element.password == password,
          orElse: () => const AuthHiveModel.initial());
      return user;
    } catch (e) {
      print("❌ Error logging in user: $e");
      throw Exception("Failed to login user: $e");
    }
  }

  // =====================
  // ✅ Category Queries
  // =====================

  Future<void> createCategory(CategoryHiveModel category) async {
    try {
      var box =
          await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
      await box.put(category.categoryId, category);
    } catch (e) {
      print("❌ Error creating category: $e");
      throw Exception("Failed to create category: $e");
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      var box =
          await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
      await box.delete(categoryId);
    } catch (e) {
      print("❌ Error deleting category: $e");
      throw Exception("Failed to delete category: $e");
    }
  }

  Future<List<CategoryHiveModel>> getAllCategories() async {
    try {
      var box =
          await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
      return box.values.toList()..sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      print("❌ Error fetching categories: $e");
      throw Exception("Failed to fetch categories: $e");
    }
  }

  // =====================
  // ✅ Utility Functions
  // =====================

  Future<void> clearAll() async {
    try {
      await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
      await Hive.deleteBoxFromDisk(HiveTableConstant.categoryBox);
      await Hive.deleteBoxFromDisk(HiveTableConstant.postBox);
    } catch (e) {
      print("❌ Error clearing all boxes: $e");
      throw Exception("Failed to clear all boxes: $e");
    }
  }

  Future<void> close() async {
    try {
      await Hive.close();
    } catch (e) {
      print("❌ Error closing Hive: $e");
      throw Exception("Failed to close Hive: $e");
    }
  }
}
