import 'package:admin/helper/my_logger_helper.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  static MainScreenController get instance => Get.find();

  final currentScreenIndex = 0.obs;

  String currentState() =>
      'MainScreenController(currentScreenIndex ${currentScreenIndex.value})';

  void updateScreenIndex(int index) {
    currentScreenIndex.value = index;
    MyLogger.printInfo(currentState());
  }
}
