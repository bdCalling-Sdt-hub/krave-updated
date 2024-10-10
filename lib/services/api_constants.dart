class ApiConstants{
  static const String baseUrl = "http://192.168.10.11:8350/api/v1";
  static const String imageBaseUrl = "http://192.168.10.11:8350";


  static const String signUpEndPoint = "/users/register";
  static const String verifyPhoneEndPoint = "/users/verify-code";
  static const String signInEndPoint = "/users/login";
  static const String forgotPasswordPoint = "/auth/forgot";
  static const String profileEndPoint = "/auth/session";
  static  String profileMoreInfoEndPoint(String id) => "/profile/$id";
  static const String theme = "/themes";
  static const String subscriptions = "/subscriptions";
  static const String blogs = "/blogs";
  static const String activities = "/activities";
  static const String privacy = "/app-data";
  static const String payments = "/payments";
  static const  String resendOtpEndPoint = "/users/forgot-password";
  static  String setPasswordEndPoint(String userId) => "/users/$userId";
  static  String editProfile(String userId) => "/users/$userId";
  static  String photoUploadAuth(String userId) => "/gallery/$userId";





}