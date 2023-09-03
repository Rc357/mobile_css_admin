import 'package:admin/module/add_survey/bindings/add_survey_binding.dart';
import 'package:admin/module/add_survey/views/add_survey_view.dart';
import 'package:admin/module/add_survey/widgets/preview_image.dart';
import 'package:admin/module/add_survey_version/bindings/add_survey_binding.dart';
import 'package:admin/module/add_survey_version/views/add_survey_version_view.dart';
import 'package:admin/module/dashboard_admin_office/bindings/dashboard_admin_office_binding.dart';
import 'package:admin/module/dashboard_admin_office/views/admin_office_screen.dart';
import 'package:admin/module/dashboard_cashier/bindings/dashboard_cashier_binding.dart';
import 'package:admin/module/dashboard_cashier/views/cashier_screen.dart';
import 'package:admin/module/dashboard_library/bindings/dashboard_library_binding.dart';
import 'package:admin/module/dashboard_library/views/library_screen.dart';
import 'package:admin/module/dashboard_registrar/bindings/dashboard_registrar_binding.dart';
import 'package:admin/module/dashboard_registrar/views/registrar_screen.dart';
import 'package:admin/module/dashboard_security_admin_office/bindings/dashboard_security_binding.dart';
import 'package:admin/module/dashboard_security_admin_office/views/security_admin_office_screen.dart';
import 'package:admin/module/forgot_password/bindings/forgot_password_binding.dart';
import 'package:admin/module/forgot_password/views/forgot_password_view.dart';
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
  static const FORGET_PASSWORD = Routes.FORGET_PASSWORD;
  static const ADD_SURVEY_VERSION = Routes.ADD_SURVEY_VERSION;
  static const DASHBOARD_LIBRARY = Routes.DASHBOARD_LIBRARY;
  static const DASHBOARD_CASHIER = Routes.DASHBOARD_CASHIER;
  static const DASHBOARD_REGISTRAR = Routes.DASHBOARD_REGISTRAR;
  static const DASHBOARD_SECURITY = Routes.DASHBOARD_SECURITY;
  static const DASHBOARD_ADMIN_OFFICE = Routes.DASHBOARD_ADMIN_OFFICE;

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
      name: _Paths.ADD_SURVEY_VERSION,
      page: () => AddSurveyVersionView(),
      binding: AddSurveyVersionBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_LIBRARY,
      page: () => LibraryScreen(),
      binding: DashboardLibraryBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_CASHIER,
      page: () => CashierScreen(),
      binding: DashboardCashierBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_REGISTRAR,
      page: () => RegistrarScreen(),
      binding: DashboardRegistrarBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_SECURITY,
      page: () => SecurityAdminOfficeScreen(),
      binding: DashboardSecurityBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_ADMIN_OFFICE,
      page: () => AdminOfficeScreen(),
      binding: DashboardAdminOfficeBinding(),
    ),
    GetPage(
      name: _Paths.PREVIEW_IMAGE,
      page: () => PreviewImageWidget(),
      // binding: AddSurveyBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
