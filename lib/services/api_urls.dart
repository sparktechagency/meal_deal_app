class ApiUrls {

  /// ============= base urls ===========>>>
  static const String baseUrl = "https://mihad8000.merinasib.shop/api/v1";
  static const String imageBaseUrl = "https://mihad8000.merinasib.shop/api/v1/";
  static const String socketUrl = "https://mihad8000.merinasib.shop/api/v1";





  /// ============= all urls ===========>>>

  static const String register = '/auth/create-account';
  static const String verifyOtp = '/auth/verify-otp';
  static const String login = '/auth/login';
  static  const String  resetPassword = '/auth/reset-password';
  static const String forgetPassword = '/auth/forget-password';
  static const String freelanceRules = '/freelance';
  static const String trackMe = '/users/track-me';
  static const String userMe = '/users/me';
  static const String businessNumber = '/klzh/verify-klzh';
  static const String compliance = '/hygiene-compliance/';
  static const String become = '/cook/become-a-cook';
  static const String contracts = '/contracts/';
  static  String mealTest (int page,int limit) => '/meal?limit=$limit&page=$page';
  static  String order(String status,int page,int limit) => '/order/current-orders?status=$status&limit=$limit&page=$page';
  static const String courses = '/courses/';
  static  String orderHistory (int page,int limit) => '/order/recent-orders?limit=$limit&page=$page';
  static const String category = '/category/';
  static  String submitQuizUrl(String quizID) => '/courses/submit-quiz/$quizID/';
  static const String addMeal = '/meal/add-meal';
  static const String cookVerify = '/cook-verify/verify-cook-id';









}
