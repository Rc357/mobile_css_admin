import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum AuthStatus { unauthenticated, authenticated, error }

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final status = AuthStatus.unauthenticated.obs;
  late Worker _statusEverWorker;

  late Rx<User?> firebaseUser;

  String currentState() =>
      'AuthController(status: ${status.value}, firebaseUser: ${firebaseUser.value})';

  @override
  void onReady() {
    super.onReady();
    _monitorAuthStatus();
    _monitorFirebaseUser();
  }

  @override
  void onClose() {
    firebaseUser.close();
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorFirebaseUser() {
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.authStateChanges());
    ever(firebaseUser, (User? value) {
      if (value != null) {
        status.value = AuthStatus.authenticated;
      } else {
        status.value = AuthStatus.unauthenticated;
      }
    });
  }

  void _monitorAuthStatus() {
    _statusEverWorker = ever(
      status,
      (value) async {
        switch (value) {
          case AuthStatus.error:
            MyLogger.printError(currentState());
            break;
          case AuthStatus.unauthenticated:
            MyLogger.printInfo(currentState());
            Get.offAllNamed(AppPages.LOGIN);
            break;
          case AuthStatus.authenticated:
            MyLogger.printInfo(currentState());
            Get.offAllNamed(AppPages.MAIN_SCREEN);
            break;
        }
      },
    );
  }
}
