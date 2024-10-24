class ApiConstants{
  static const String baseUrl = "http://192.168.10.11:8350/api/v1";
  static const String imageBaseUrl = "http://192.168.10.11:8350";


  static const String signUpEndPoint = "/users/register";
  static const String verifyPhoneEndPoint = "/users/verify-code";
  static const String signInEndPoint = "/users/login";
  static const String resetPassword = "/users/forgot-password-change";
  static const String forgotPasswordPoint = "/users/forgot-password";
  static const String likeMatch = "/match";
  static const String termsEndpoint = "/terms-and-condition";
  static const String changePassword = "/users/change-password";
  static String likeMatchGet(String id) => "/match/$id";
  static  String profileEndPoint(String id) =>  "/profile/$id";
  static  String profileMoreInfoEndPoint(String id) => "/profile/$id";
  static const  String resendOtpEndPoint = "/users/forgot-password";
  static  String setDistance(String userId) => "/profile/set-distance/$userId";
  static  String setPasswordEndPoint(String userId) => "/users/$userId";
  static  String editProfile(String userId) => "/users/$userId";
  static  String profileNameEdit(String userId) => "/profile/$userId";
  static  String photoUploadAuth(String userId) => "/gallery/$userId";
  static  String homeFeed(String userId) => "/gallery/feed/$userId";




  ///chat
  static const String createChat = "/message";
  static  String getChatUser(String id) =>  "/conversations/$id";
  static  String getChats(String id) =>  "/conversations/messages/$id";


}