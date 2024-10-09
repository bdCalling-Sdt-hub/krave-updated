class ApiConstants{
  static const String baseUrl = "http://192.168.10.187:1000";
  static const String imageBaseUrl = "http://192.168.10.187:1000/";


  static const String signUpEndPoint = "/auth/register";
  static const String verifyEmailEndPoint = "/auth/otp";
  static const String signInEndPoint = "/auth/login";
  static const String forgotPasswordPoint = "/auth/forgot";
  static const String profileEndPoint = "/auth/session";
  static const String quotes = "/quotes";
  static const String theme = "/themes";
  static const String subscriptions = "/subscriptions";
  static const String blogs = "/blogs";
  static const String activities = "/activities";
  static const String privacy = "/app-data";
  static const String payments = "/payments";
  static  String resendOtpEndPoint(String userId) => "/auth/otp?userId=$userId";
  static  String setPasswordEndPoint(String userId) => "/users/$userId";
  static  String editProfile(String userId) => "/users/$userId";





}