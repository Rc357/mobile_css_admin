import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/question_model.dart';
import 'package:admin/repositories/add_admin_repository.dart';
import 'package:get/get.dart';

enum BarGraphControllerStatus { initial, loading, loaded, error }

class BarGraphController extends GetxController {
  static BarGraphController get instance => Get.find();
  late Worker _statusEverWorker;
  final _status = BarGraphControllerStatus.initial.obs;
  bool get isLoading => _status.value == BarGraphControllerStatus.loading;

  final adminData = Rxn<AdminModel>();

  final allQuestion = <QuestionModel>[].obs;

  final totalRespondents = [].obs;
  final allTotal = [].obs;
  final excellentTotal = 0.obs;
  final verySatisfactoryTotal = 0.obs;
  final satisfactoryTotal = 0.obs;
  final fairTotal = 0.obs;
  final poorTotal = 0.obs;

  String currentState() =>
      'BarGraphController(_status: ${_status.value} allQuestion: ${allQuestion.length},)';

  @override
  void onInit() {
    _monitorFeedbackFormStatus();
    getAdminData();
    super.onInit();
  }

  @override
  void onClose() {
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorFeedbackFormStatus() {
    _statusEverWorker = ever(
      _status,
      (value) async {
        switch (value) {
          case BarGraphControllerStatus.error:
            MyLogger.printError(currentState());
            break;
          case BarGraphControllerStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case BarGraphControllerStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case BarGraphControllerStatus.loaded:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void getAdminData() async {
    final currentUser = firebaseAuth.currentUser!;
    adminData.value = await AddAdminRepository.getAdminViaId(currentUser.uid);

    // await getQuestions();
    computerTotals();
  }

  // Future<void> getQuestions() async {
  //   final officeName = ''.obs;
  //   _status.value = BarGraphControllerStatus.loading;
  //   if (adminData.value != null &&
  //       adminData.value!.adminType.description != 'Super Admin') {
  //     if (adminData.value!.adminType.name == 'Admin') {
  //       officeName.value = 'questionsAdminsOffice';
  //     } else {
  //       officeName.value =
  //           "questions${adminData.value!.adminType.description.removeAllWhitespace}";
  //     }
  //     MyLogger.printError('officeName.value ${officeName.value}');

  //     try {
  //       allQuestion.value =
  //           await QuestionsRepository.getQuestions(officeName.value);
  //       _status.value = BarGraphControllerStatus.loaded;
  //       MyLogger.printInfo(currentState());
  //     } catch (e) {
  //       print('Error: $e');
  //     }
  //   }
  // }

  void computerTotals() {
    if (allQuestion.isNotEmpty) {
      for (var i in allQuestion) {
        if (i.type == QuestionTypeEnum.fivePointsCase) {
          excellentTotal.value += i.excellent;
          verySatisfactoryTotal.value += i.verySatisfactory;
          satisfactoryTotal.value += i.satisfactory;
          fairTotal.value += i.fair;
          poorTotal.value += i.poor;
          totalRespondents.add(excellentTotal.value +
              verySatisfactoryTotal.value +
              satisfactoryTotal.value +
              fairTotal.value +
              poorTotal.value);
        } else {}
      }

      allTotal.add(excellentTotal.value);
      allTotal.add(verySatisfactoryTotal.value);
      allTotal.add(satisfactoryTotal.value);
      allTotal.add(fairTotal.value);
      allTotal.add(poorTotal.value);
      // MyLogger.printError(
      //     "DATA HERE:  ${excellentTotal.value + verySatisfactoryTotal.value + satisfactoryTotal.value + fairTotal.value + poorTotal.value}");
      // // totalRespondents.add();
      // MyLogger.printError('excellentTotal ${excellentTotal.value}');
      // MyLogger.printError(
      //     'verySatisfactoryTotal ${verySatisfactoryTotal.value}');
      // MyLogger.printError('satisfactoryTotal ${satisfactoryTotal.value}');
      // MyLogger.printError('fairTotal ${fairTotal.value}');
      // MyLogger.printError('poorTotal ${poorTotal.value}');
      MyLogger.printError('totalRespondents ${totalRespondents.length}');
      MyLogger.printError('totalRespondents ${totalRespondents[0]}');
    }
  }
}
