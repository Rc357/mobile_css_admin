import 'package:admin/module/add_survey/bindings/add_survey_binding.dart';
import 'package:admin/module/add_survey/views/add_survey_view.dart';
import 'package:admin/module/add_survey/widgets/preview_image.dart';
import 'package:admin/module/login/bindings/login_binding.dart';
import 'package:admin/module/login/views/login_view.dart';
import 'package:admin/module/main/bindings/dashboard_binding.dart';
import 'package:admin/module/main/views/main_screen.dart';
import 'package:admin/splash/bindings/splash_binding.dart';
import 'package:admin/splash/views/splash_view.dart';
import 'package:get/get_navigation/get_navigation.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const SPLASH = Routes.SPLASH;
  static const LOGIN = Routes.LOGIN;
  static const MAIN_SCREEN = Routes.MAIN_SCREEN;
  static const ADD_SURVEY = Routes.ADD_SURVEY;
  static const PREVIEW_IMAGE = Routes.PREVIEW_IMAGE;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => MainScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SURVEY,
      page: () => AddSurveyView(),
      binding: AddSurveyBinding(),
    ),
    GetPage(
      name: _Paths.PREVIEW_IMAGE,
      page: () => PreviewImageWidget(),
      // binding: AddSurveyBinding(),
    ),
  ];
}
