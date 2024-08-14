class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://localhost:8000/api/";
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/register";
  static const String getUser = "user/get_user/";
  static const String updateProfile = "user/update_user/";
  static const String delete = "auth/deleteUser/";
  static const String imageUrl = "http://localhost:8000/products/";
  static const String profileImageUrl = "http://localhost:8000/profiles/";
  static const String uploadImage = "user/update_profile_image";
  static const String currentUser = "auth/getMe";
  static const String pagination = "products/pagination";
  static const String photos = "photos";

  static const String userPosts = "products/get_all_product_by_userid/";
  static const String deletePost = "/products/delete_product/";

  static const String createPost = "products/create/";

  static const String getSingleProduct = "products/get_single_product/";

  static const String searchProducts = "products/search";

  static const limitPage = 20;
  // ====================== Batch Routes ======================
  // static const String createBatch = "batch/createBatch";
  // static const String getAllBatch = "batch/getAllBatches";

  // ====================== Course Routes ======================
  // static const String createCourse = "course/createCourse";
  // static const String deleteCourse = "course/";
  // static const String getAllCourse = "course/getAllCourse";

  static const String createReviews = "products/create_review";
  static const String getProductReviews = "products/reviews/";

  // Favorite Routes
  static const String addFavorite = "products/add_favorite";
  static const String removeFavorite = "products/remove_favorite/";
  static const String getFavorites = "products/favorites/";

  // Forgot Routes
  static const String forgotPassword = "user/forgot_password";
  static const String verifyOtp = "user/verify_otp";

  // Booking Endpoints
  static const String createBooking = "bookings/create";
  static const String getAllBookings = "bookings/all";
  static const String getBooking = "bookings/booking";
  static const String cancelBooking = "bookings/cancel/";

  // Cart Operations
  static const String addCart = "products/add_cart";
  static const String removeCart = "products/remove_cart/";
  static const String getCartItems = "products/get_cart";
}
