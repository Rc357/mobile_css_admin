import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetController extends GetxController {
  static CheckInternetController get instance => Get.find();

  final checkNet = true.obs;

  @override
  void onInit() {
    checkInternet();
    super.onInit();
  }

  Future checkInternet() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    checkNet.value = isConnected;
  }
}
