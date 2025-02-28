class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:8000/api/v1/";
  // static String baseUrl = "http://192.168.11.1:8000/api/v1";

  // ===================== ✅ User Routes =====================
  static const String login = "user/login";
  static const String register = "user/register";
  static const String getAllUsers = "user/all";
  static const String getCurrentUser = "user/getMe";

  // ======================== Post Routes =============================
  static const String createPost = "post/addpost/";
  static const String getAllPosts = "post/all";
  static const String deletePost = "post/";
  static const String getPostById =
      "post"; // ✅ Fetch single post (ID will be appended in requests)
  static const String updatePost =
      "post"; // The ID will be appended in requests

  static const String getMe = "user/getMe";
  static const String getUserById = "user/getUserById/";
  static const String updateUser = "user/profile/edit/";
  static const String deleteUser = "user/deleteUser/";

  static const String imageUrl = "http://10.0.2.2:8000/uploads";
  static const String uploadImage = "user/uploadImage";
  static const String uploadPostsImage = "post/uploadPostsImage";
  static const String updateProfilePicture = "user/updateProfilePicture";
  static const String deleteProfilePicture = "user/deleteProfilePicture";

  // ======================== Category Routes =============================
  static const String createCategory = "category/";
  static const String getAllCategories = "category/getAllCategories";
  static const String deleteCategory = "category/";
// ===================== ✅ Chat (Message) Routes =====================
  static const String sendMessage = "message/send/"; // ✅ Fix: Matches Backend
  static const String getMessages = "message/all/"; // ✅ Fix: Matches Backend
  static const String deleteMessage =
      "message/"; // ❓ Check if exists in backend

  // ===================== ✅ Password Routes =====================
  static const String forgotPassword = "user/forgot-password";
  static const String resetPassword = "user/reset-password";
}
