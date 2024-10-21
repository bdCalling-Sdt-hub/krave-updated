class ApiConstants{
  static const String baseUrl = "http://192.168.10.11:8350/api/v1";
  static const String imageBaseUrl = "http://192.168.10.11:8350";


  static const String signUpEndPoint = "/users/register";
  static const String verifyPhoneEndPoint = "/users/verify-code";
  static const String signInEndPoint = "/users/login";
  static const String resetPassword = "/users/forgot-password-change";
  static const String forgotPasswordPoint = "/users/forgot-password";
  static const String likeMatch = "/match";
  static  String profileEndPoint(String id) =>  "/profile/$id";
  static  String profileMoreInfoEndPoint(String id) => "/profile/$id";
  static const  String resendOtpEndPoint = "/users/forgot-password";
  static  String setPasswordEndPoint(String userId) => "/users/$userId";
  static  String editProfile(String userId) => "/users/$userId";
  static  String photoUploadAuth(String userId) => "/gallery/$userId";
  static  String homeFeed(String userId) => "/gallery/feed/$userId";





}