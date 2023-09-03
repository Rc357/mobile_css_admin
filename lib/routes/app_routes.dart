part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const MAIN_SCREEN = _Paths.MAIN_SCREEN;
  static const ADD_SURVEY = _Paths.ADD_SURVEY;
  static const PREVIEW_IMAGE = _Paths.PREVIEW_IMAGE;
  static const FORGET_PASSWORD = _Paths.FORGET_PASSWORD;
  static const ADD_SURVEY_VERSION = _Paths.ADD_SURVEY_VERSION;
  static const DASHBOARD_LIBRARY = _Paths.DASHBOARD_LIBRARY;
  static const DASHBOARD_CASHIER = _Paths.DASHBOARD_CASHIER;
  static const DASHBOARD_REGISTRAR = _Paths.DASHBOARD_REGISTRAR;
  static const DASHBOARD_SECURITY = _Paths.DASHBOARD_SECURITY;
  static const DASHBOARD_ADMIN_OFFICE = _Paths.DASHBOARD_ADMIN_OFFICE;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const MAIN_SCREEN = '/main-screen';
  static const ADD_SURVEY = '/add-survey';
  static const PREVIEW_IMAGE = '/preview_image';
  static const FORGET_PASSWORD = '/forget-password';
  static const ADD_SURVEY_VERSION = '/add-survey-version';
  static const DASHBOARD_LIBRARY = '/dashboard-library';
  static const DASHBOARD_CASHIER = '/dashboard-cashier';
  static const DASHBOARD_REGISTRAR = '/dashboard-registrar';
  static const DASHBOARD_SECURITY = '/dashboard-security';
  static const DASHBOARD_ADMIN_OFFICE = '/dashboard-admin-office';
}
