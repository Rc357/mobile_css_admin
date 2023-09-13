import 'dart:math';
import 'package:admin/enums/type_user_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/question_model.dart';
import 'package:admin/models/survey_remarks.dart';
import 'package:admin/models/user_security_office_model.dart';
import 'package:admin/module/dashboard/widgets/hashtag.dart';
import 'package:admin/repositories/add_admin_repository.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:admin/repositories/remarks_repository.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SecurityOfficeBarGraphControllerStatus { initial, loading, loaded, error }

class SecurityOfficeBarGraphController extends GetxController {
  static SecurityOfficeBarGraphController get instance => Get.find();
  late Worker _statusEverWorker;
  final _status = SecurityOfficeBarGraphControllerStatus.initial.obs;
  bool get isLoading =>
      _status.value == SecurityOfficeBarGraphControllerStatus.loading;

  final adminData = Rxn<AdminModel>();

  final allQuestion = <QuestionModel>[].obs;
  final questionLatestVersion = Rxn<QuestionModel>();

  final users = <UserSecurityOfficeModel>[].obs;
  final totalAlumni = 0.obs;
  final totalParent = 0.obs;
  final totalGuest = 0.obs;
  final totalStudent = 0.obs;

  final officeName = 'questionsSecurityOffice';
  final officeNameUser = 'userSecurityOffice';
  final version = 0.obs;
  final listVersion = [].obs;
  final intervalNumber = 1.0.obs;

  final kFlutterHashtags = [].obs;

  final List<Color> fixedColors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.grey,
    Colors.black54,
    Colors.black12,
    Color(0xFFFFC108),
    Color(0xFF0175C2),
    Color(0xFF60646B),
    Color(0xFF202124),
  ];

  final List<int> fixedSized = [
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
  ];

  final List<bool> fixedBool = [true, false, false, true, false, false];

  String currentState() =>
      'SecurityOfficeBarGraphController(_status: ${_status.value} allQuestion: ${allQuestion.length},)';

  @override
  void onInit() {
    _monitorFeedbackFormStatus();
    getLatestVersion();
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
          case SecurityOfficeBarGraphControllerStatus.error:
            MyLogger.printError(currentState());
            break;
          case SecurityOfficeBarGraphControllerStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case SecurityOfficeBarGraphControllerStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case SecurityOfficeBarGraphControllerStatus.loaded:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void resetData() {
    totalAlumni.value = 0;
    totalParent.value = 0;
    totalGuest.value = 0;
    totalStudent.value = 0;
    kFlutterHashtags.clear();
  }

  void setInterval() {
    if (allQuestion.length < 10) {
      intervalNumber.value = 1;
    } else if (allQuestion.length > 10 && allQuestion.length <= 50) {
      intervalNumber.value = 5;
    } else if (allQuestion.length > 50 && allQuestion.length <= 100) {
      intervalNumber.value = 10;
    } else if (allQuestion.length > 100 && allQuestion.length <= 150) {
      intervalNumber.value = 15;
    } else if (allQuestion.length > 150 && allQuestion.length <= 200) {
      intervalNumber.value = 20;
    } else if (allQuestion.length > 200 && allQuestion.length <= 250) {
      intervalNumber.value = 25;
    } else if (allQuestion.length > 250 && allQuestion.length <= 300) {
      intervalNumber.value = 30;
    } else if (allQuestion.length > 300 && allQuestion.length <= 350) {
      intervalNumber.value = 35;
    } else if (allQuestion.length > 350 && allQuestion.length <= 400) {
      intervalNumber.value = 40;
    } else if (allQuestion.length > 400 && allQuestion.length <= 450) {
      intervalNumber.value = 45;
    } else if (allQuestion.length > 450 && allQuestion.length <= 500) {
      intervalNumber.value = 50;
    } else if (allQuestion.length > 500 && allQuestion.length <= 550) {
      intervalNumber.value = 55;
    } else if (allQuestion.length > 550 && allQuestion.length <= 600) {
      intervalNumber.value = 60;
    } else if (allQuestion.length > 600 && allQuestion.length <= 650) {
      intervalNumber.value = 65;
    } else if (allQuestion.length > 650 && allQuestion.length <= 700) {
      intervalNumber.value = 70;
    } else if (allQuestion.length > 700 && allQuestion.length <= 750) {
      intervalNumber.value = 75;
    } else if (allQuestion.length > 750 && allQuestion.length <= 800) {
      intervalNumber.value = 80;
    } else if (allQuestion.length > 800 && allQuestion.length <= 850) {
      intervalNumber.value = 85;
    } else if (allQuestion.length > 850 && allQuestion.length <= 900) {
      intervalNumber.value = 90;
    } else if (allQuestion.length > 900 && allQuestion.length <= 950) {
      intervalNumber.value = 95;
    } else if (allQuestion.length > 950 && allQuestion.length <= 1000) {
      intervalNumber.value = 100;
    } else if (allQuestion.length > 1000 && allQuestion.length <= 1050) {
      intervalNumber.value = 105;
    } else if (allQuestion.length > 1050 && allQuestion.length <= 1100) {
      intervalNumber.value = 110;
    } else if (allQuestion.length > 1100 && allQuestion.length <= 1150) {
      intervalNumber.value = 115;
    } else if (allQuestion.length > 1150 && allQuestion.length <= 1200) {
      intervalNumber.value = 120;
    } else {
      intervalNumber.value = 500;
    }
  }

  void setVersion(int versionPass) {
    version.value = versionPass;
    resetData();
    getAdminData();
  }

  void getAdminData() async {
    final currentUser = firebaseAuth.currentUser!;
    adminData.value = await AddAdminRepository.getAdminViaId(currentUser.uid);

    await getQuestions();
    // computeTotals();
    getRemarksList();
  }

  Future<void> getUserTotals(String officeName) async {
    MyLogger.printError('getUserTotals');
    users.value = await UserRepository.getUsersSecurityOfficeAnswered(
        office: officeName, version: version.value);

    MyLogger.printError('users.length : ${users.length}');

    for (int i = 0; i < users.length; i++) {
      if (users[i].userType == UserTypeEnum.alumni) {
        totalAlumni.value += 1;
      }
      if (users[i].userType == UserTypeEnum.parents) {
        totalParent.value += 1;
      }
      if (users[i].userType == UserTypeEnum.guest) {
        totalGuest.value += 1;
      }
      if (users[i].userType == UserTypeEnum.student) {
        totalStudent.value += 1;
      }
    }
  }

  void getLatestVersion() async {
    _status.value = SecurityOfficeBarGraphControllerStatus.loading;

    questionLatestVersion.value =
        await QuestionsRepository.findLatestVersion(officeName);
    version.value = questionLatestVersion.value!.version;

    MyLogger.printInfo("GET QUESTION VERSION: ${version.value}");
    listVersion.clear();
    for (int i = 1; i <= version.value; i++) {
      listVersion.add(i);
    }
    getAdminData();
  }

  Future<void> getQuestions() async {
    _status.value = SecurityOfficeBarGraphControllerStatus.loading;

    try {
      allQuestion.value =
          await QuestionsRepository.getQuestions(officeName, version.value);
      _status.value = SecurityOfficeBarGraphControllerStatus.loaded;
      setInterval();
      MyLogger.printInfo(currentState());
    } catch (e) {
      print('Error: $e');
    }

    await getUserTotals(officeNameUser);
  }

  void getRemarksList() async {
    try {
      List<SurveyRemarksModel>? listRemarks =
          await RemarksRepository.getRemarksList(
              'securityOffice', version.value);
      addHashtagData(listRemarks);

      MyLogger.printInfo(currentState());
    } catch (e) {
      print('Error: $e');
    }
  }

  void addHashtagData(List<SurveyRemarksModel>? listRemarks) {
    if (listRemarks != null) {
      for (int i = 0; i < listRemarks.length; i++) {
        kFlutterHashtags.add(FlutterHashtag(listRemarks[i].remarks,
            getRandomColor(), getRandomSized(), getRandomBool()));
      }
    }
  }

  Color getRandomColor() {
    final random = Random();
    return fixedColors[random.nextInt(fixedColors.length)];
  }

  int getRandomSized() {
    final random = Random();
    return fixedSized[random.nextInt(fixedSized.length)];
  }

  bool getRandomBool() {
    final random = Random();
    return fixedBool[random.nextInt(fixedBool.length)];
  }
}
