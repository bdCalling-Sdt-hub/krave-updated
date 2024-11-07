import 'package:get/get.dart';
import 'package:krave/views/screen/Auth/Verify_otp/otp.dart';
import 'package:krave/views/screen/Auth/personal_details.dart';
import 'package:krave/views/screen/Auth/reset_screen.dart';
import 'package:krave/views/screen/Auth/sign_in.dart';
import 'package:krave/views/screen/Auth/upload_photos.dart';
import 'package:krave/views/screen/Chats/chat_page.dart';
import 'package:krave/views/screen/Chats/chats_details_screen.dart';
import 'package:krave/views/screen/OnBoard/onboard_screen.dart';
import 'package:krave/views/screen/Profile/account_information.dart';
import 'package:krave/views/screen/Profile/edit_account_information.dart';
import 'package:krave/views/screen/Profile/edit_personalInformation.dart';
import 'package:krave/views/screen/Profile/personal_information.dart';
import 'package:krave/views/screen/Profile/update_pictures.dart';
import 'package:krave/views/screen/Home/match_screen.dart';
import 'package:krave/views/screen/Matches/match_screen.dart';
import 'package:krave/views/screen/Matches/matches_profile_details.dart';
import 'package:krave/views/screen/Matches/matches_screen.dart';
import 'package:krave/views/screen/Settings/about_us.dart';
import 'package:krave/views/screen/Settings/change_password.dart';
import 'package:krave/views/screen/Settings/find_resturants.dart';
import 'package:krave/views/screen/Settings/privacy_policy.dart';
import 'package:krave/views/screen/Settings/restaurant_details.dart';
import 'package:krave/views/screen/Settings/set_distance.dart';
import 'package:krave/views/screen/Settings/settings_screen.dart';
import 'package:krave/views/screen/Settings/terms_sevices.dart';
import 'package:krave/views/screen/notifications/notifications_screen.dart';
import '../main.dart';
import '../views/screen/Auth/forgot.dart';
import '../views/screen/Auth/location.dart';
import '../views/screen/Auth/sign_up.dart';
import '../views/screen/Home/home_screen.dart';
import '../views/screen/Home/profile_details.dart';
import '../views/screen/Profile/profile_screen.dart';
import '../views/screen/Splash/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String onboardScreen = "/onboard_screen";
  static String homeScreen = "/home_screen";
  // static String matchScreen = "/match_screen";
  static String profileDetailsScreen = "/ProfileDetails_screen";
  static String profileScreen = "/profile_screen";
  // static String matchesScreen = "/matches_screen";
  static String notificationsScreen = "/notifications_screen";

  ///Authentication======>
  static String signInScreen = "/signIn_screen";
  static String signUpScreen = "/signup_screen";
  static String forgetPasswordScreen = "/forgetPassword_screen";
  static String otpScreen = "/otp_screen";
  static String resetScreen = "/reset_screen";
  static String uploadPhotosScreen = "/uploadPhotos_screen";
  static String detailsScreen = "/details_screen";
  static String locationScreen = "/location_screen";

  ///Matches======>
  static String matchDetailsScreen = "/match_details_screen";
  static String matchesProfileDetailsScreen = "/matches_profile_details_screen";

  ///Matches======>
  static String chatDetailsScreen = "/chat_details_screen";
  static String chatPageScreen = "/chat_page_screen";
  ///Profile======>
  static String updatePictureScreen = "/update_picture_screen";
  static String accountInformationScreen = "/account_information_screen";
  static String editAccountInformationScreen = "/edit_account_information_screen";
  static String personalInformationScreen = "/personal_information_screen";
  static String editPersonalInformationScreen = "/edit_personal_information_screen";

  ///Settings======>
  static String settingsScreen = "/settings_screen";
  static String changePasswordScreen = "/change_password_screen";
  static String privacyPolicyScreen = "/privacy_policy_screen";
  static String termsServicesScreen = "/terms_services_screen";
  static String aboutUsScreen = "/about_us_screen";
  static String findRestaurantScreen = "/find_restaurant_screen";
  static String restaurantDetailsScreen = "/restaurant_details_screen";
  static String setDistanceScreen = "/set_distance_screen";
  static String matchScreen = "/MatchScreen";

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
        name: homeScreen,
        page: () => HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: matchScreen,
        page: () =>  MatchScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: profileScreen,
        page: () =>  ProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: signUpScreen,
        page: () => const SignUpScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: signInScreen,
        page: () => const SignInScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: forgetPasswordScreen,
        page: () => const ForegetPasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: otpScreen,
        page: () => const OtpScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: resetScreen,
        page: () => const ResetScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: uploadPhotosScreen,
        page: () => const UpdatePhotosScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: detailsScreen,
        page: () => const DetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: locationScreen,
        page: () => const LocationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: profileDetailsScreen,
        page: () => ProfileDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    // GetPage(
    //     name: matchScreen,
    //     page: () => MatchScreen(),
    //     transition: Transition.noTransition),
    GetPage(
        name: notificationsScreen,
        page: () => const NotificationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: matchDetailsScreen,
        page: () =>  MatchDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: matchesProfileDetailsScreen,
        page: () => const MatchesProfileDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: updatePictureScreen,
        page: () => const UpdatePictureScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: accountInformationScreen,
        page: () => const AccountInformation(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: editAccountInformationScreen,
        page: () => const EditAccountInformation(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: personalInformationScreen,
        page: () => const PersonalInformation(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: editPersonalInformationScreen,
        page: () => const EditPersonalInformation(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: chatDetailsScreen,
        page: () =>  ChatDetailsScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: chatPageScreen,
        page: () => const ChatPageScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: settingsScreen,
        page: () =>  SettingsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: changePasswordScreen,
        page: () => const ChangePasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: privacyPolicyScreen,
        page: () =>  PrivacyPolicyScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: termsServicesScreen,
        page: () =>  TermsServicesScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: aboutUsScreen,
        page: () =>  AboutUsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: findRestaurantScreen,
        page: () =>  FindRestaurantScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: restaurantDetailsScreen,
        page: () =>  RestaurantDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: onboardScreen,
        page: () =>  OnboardScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
    GetPage(
        name: setDistanceScreen,
        page: () => const SetDistanceScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),),
  ];
}
