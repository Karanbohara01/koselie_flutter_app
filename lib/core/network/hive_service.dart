import 'package:hive_flutter/hive_flutter.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';
import 'package:koselie/features/auth/data/model/auth_hive_model.dart';
import 'package:koselie/features/auth/data/model/post_hive_model.dart';
import 'package:koselie/features/category/data/model/category_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}koselie_app.db';

    Hive.init(path);

    // Register Adapters

    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(PostHiveModelAdapter());
    Hive.registerAdapter(CategoryHiveModelAdapter());
  }

  //  Categories Queries

  // Batch Queries
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
    // Sort by BatchName
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    return box.values.toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  // Post Queries
  Future<void> createPost(PostHiveModel post) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.put(post.postId, post);
    await box.close();
  }

  Future<PostHiveModel?> getPost(String postId) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    final post = box.get(postId);
    await box.close();
    return post;
  }

  Future<List<PostHiveModel>> getAllPosts() async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    final posts = box.values.toList();
    await box.close();
    return posts;
  }

  Future<void> deletePost(String postId) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.delete(postId); // Use the postId as the key
    await box.close();
  }

  Future<void> updatePost(PostHiveModel post) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.put(post.postId, post); // Use the postId as the key
    await box.close();
  }

  // Auth Queries
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

  // Login using username and password
  Future<AuthHiveModel?> loginUser(String username, String password) async {
    // var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    // var auth = box.values.firstWhere(
    //     (element) =>
    //         element.username == username && element.password == password,
    //     orElse: () => AuthHiveModel.initial());
    // return auth;

    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear Student Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
