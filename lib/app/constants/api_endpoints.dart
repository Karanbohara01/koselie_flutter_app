class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:8000/api/v1/";

  // ================= user Routes =========================
  static const String login = "user/login";
  static const String register = "user/register";
  static const String getAllStudents = "user/getAllUsers";
  static const String getCurrentUser = "user/getCurrentUser";
  static const String getStudentsByBatch = "user/getStudentsByBatch/";
  static const String getStudentsByCourse = "user/getStudentsByCourse/";
  static const String updateStudent = "user/updateStudent/";
  static const String updateUser = "user/updateUser/";
  static const String getUserById = "user/getUserById/";
  static const String getAllUsers = "user/getAllUsers/";
  static const String deleteUser = "user/deleteUser/";
  static const String deleteStudent = "user/deleteStudent/";

  static const String imageUrl = "http://10.0.2.2:8000/uploads";
  static const String uploadImage = "user/uploadImage";
  static const String updateProfilePicture = "user/updateProfilePicture";
  static const String deleteProfilePicture = "user/deleteProfilePicture";

  // ======================== Batch Routes =============================
  static const String createBatch = "batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";
  // ======================== Category Routes =============================
  static const String createCategory = "category/";
  static const String getAllCategories = "category/getAllCategories";
  static const String deleteCategory = "category/";

  // ======================== Batch Routes =============================
  static const String createCourse = "course/createCourse";
  static const String deleteCourse = "course/";
  static const String getAllCourse = "course/getAllCourse";
}
