// import 'package:admin/enums/admin_enum.dart';
// import 'package:admin/helper/my_logger_helper.dart';
// import 'package:get/get.dart';

// enum DashSuperAdminControllerStatus { initial, loading, loaded, error }

// class DashSuperAdminGraphController extends GetxController {
//   static DashSuperAdminGraphController get instance => Get.find();
//   late Worker _statusEverWorker;
//   final _status = DashSuperAdminControllerStatus.initial.obs;
//   bool get isLoading => _status.value == DashSuperAdminControllerStatus.loading;

//   String currentState() =>
//       'DashSuperAdminGraphController(_status: ${_status.value} ,)';

//   @override
//   void onInit() {
//     _monitorFeedbackFormStatus();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     _statusEverWorker.dispose();
//     super.onClose();
//   }

//   void _monitorFeedbackFormStatus() {
//     _statusEverWorker = ever(
//       _status,
//       (value) async {
//         switch (value) {
//           case DashSuperAdminControllerStatus.error:
//             MyLogger.printError(currentState());
//             break;
//           case DashSuperAdminControllerStatus.loading:
//             MyLogger.printInfo(currentState());
//             break;
//           case DashSuperAdminControllerStatus.initial:
//             MyLogger.printInfo(currentState());
//             break;
//           case DashSuperAdminControllerStatus.loaded:
//             MyLogger.printInfo(currentState());
//             break;
//         }
//       },
//     );
//   }
// }
