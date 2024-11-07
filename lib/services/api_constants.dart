class ApiConstants{
  static const String baseUrl = "https://sought-twenty-seed-wins.trycloudflare.com/api/v1";
  static const String imageBaseUrl = "https://sought-twenty-seed-wins.trycloudflare.com";


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
  static  String deletePhoto(String userId) => "/gallery/$userId";
  static  String notification(String userId) => "/notification?notificationId=$userId";
  static  String congratulationsEndPoint(String myId, userId) => "/match/congratulate?userId1=$myId&userId2=$userId";



  ///chat
  static const String createChat = "/message";
  static const String blockUser = "/block";
  static const String deleteUsers = "/users";
  static  String unBlockUser({required String userId, blockUserId}) => "/block?userId=$userId&blockedUserId=$blockUserId";
  static  String getChatUser(String id) =>  "/conversations/$id";
  static  String getChats(String id, pageNo) =>  "/conversations/messages/$id?page=$pageNo&limit=15";


}