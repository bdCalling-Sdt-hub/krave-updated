import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/socket_service.dart';
import 'package:krave/themes/light_theme.dart';
import 'package:krave/utils/app_constants.dart';
import 'package:krave/utils/message.dart';
import 'package:krave/views/base/custom_text.dart';
import 'package:krave/views/screen/Splash/splash_screen.dart';


import 'controllers/localization_controller.dart';
import 'controllers/theme_controller.dart';
import 'helpers/device_utils.dart';
import 'helpers/di.dart' as di;
import 'helpers/route.dart';
void main()async {
  SocketServices.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => ConnectivityService(), fenix: true);
  ///*******device lock **************//
  DeviceUtils.lockDevicePortrait();
  Map<String, Map<String, String>> _languages = await di.init();
  runApp( MyApp(languages:_languages,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return  GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_ , child) {
            return GetMaterialApp(

              title: AppConstants.APP_NAME,
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
             // theme: themeController.darkTheme ? dark(): light(),
              theme: light(),
              defaultTransition: Transition.topLevel,
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
              transitionDuration: const Duration(milliseconds: 500),
              getPages: AppRoutes.page,
              initialRoute: AppRoutes.splashScreen,
              home: SplashScreen(),
            );
          }
        );
      }
    );

    }
    );

  }

}






class ConnectivityService extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  ConnectivityService() {
    // Initialize connectivity status and set up a listener for connectivity changes.
    _initializeConnectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print("================change connection ${result}");
      _updateConnectionStatus(result);
    });
  }

  Future<void> _initializeConnectivity() async {
    // Check the initial connectivity status
    final status = await _connectivity.checkConnectivity();
    isConnected.value = status != ConnectivityResult.none;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    // Update the connectivity status based on the result
    isConnected.value = result != ConnectivityResult.none;
  }
}

class NoInterNetScreen extends StatelessWidget {
  final bool? isToast;
  final bool? isAppBar;
  final Widget child;

  const NoInterNetScreen(
      {super.key,
        required this.child,
        this.isToast = false,
        this.isAppBar = true});

  @override
  Widget build(BuildContext context) {
    // Retrieve the ConnectivityService instance
    final ConnectivityService connectivityService = Get.put(ConnectivityService());

    return Stack(
      children: [
        child,
        Obx(() {
          if (!connectivityService.isConnected.value) {
            return isToast == false
                ? Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_net.png"),
                  CustomText(
                      text: "Oops!",
                      fontsize: 30.h,
                      color: Colors.red,
                      top: 10.h,
                      fontWeight: FontWeight.w800,
                      bottom: 10.h),
                  CustomText(
                    text:
                    "There was some problem, Check your connection and try again",
                    maxline: 3,
                    left: 30.w,
                    right: 30.w,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            )
                : Positioned(
              top: isAppBar == true ? 50 : -5,
              right: 0,
              left: 0,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8.w),
                      const Text(
                        'No Internet Connection',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}



