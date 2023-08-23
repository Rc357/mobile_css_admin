part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const MAIN_SCREEN = _Paths.MAIN_SCREEN;
  static const ADD_SURVEY = _Paths.ADD_SURVEY;
  static const PREVIEW_IMAGE = _Paths.PREVIEW_IMAGE;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const MAIN_SCREEN = '/main-screen';
  static const ADD_SURVEY = '/add-survey';
  static const PREVIEW_IMAGE = '/previe_image';
}
