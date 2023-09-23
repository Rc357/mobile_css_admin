import 'dart:math';

import 'package:pdf/widgets.dart ' as pw;
import 'package:universal_html/html.dart' as html;
import 'package:screenshot/screenshot.dart';
import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/enums/type_user_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/question_average_model.dart';
import 'package:admin/models/question_model.dart';
import 'package:admin/models/survey_remarks.dart';
import 'package:admin/models/user_admin_office_model.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/hashtag.dart';
import 'package:admin/repositories/add_admin_repository.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:admin/repositories/remarks_repository.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AdminOfficeBarGraphControllerStatus { initial, loading, loaded, error }

class AdminOfficeBarGraphController extends GetxController {
  static AdminOfficeBarGraphController get instance => Get.find();
  late Worker _statusEverWorker;
  final status = AdminOfficeBarGraphControllerStatus.initial.obs;
  bool get isLoading =>
      status.value == AdminOfficeBarGraphControllerStatus.loading;

  final adminData = Rxn<AdminModel>();

  final allQuestion = <QuestionModel>[].obs;
  final questionLatestVersion = Rxn<QuestionModel>();

  final users = <UserAdminOfficeModel>[].obs;
  final totalAlumni = 0.obs;
  final totalParent = 0.obs;
  final totalGuest = 0.obs;
  final totalStudent = 0.obs;

  final averageAlumni = 0.0.obs;
  final averageParent = 0.0.obs;
  final averageGuest = 0.0.obs;
  final averageStudent = 0.0.obs;
  final totalAverageFivePoints = 0.0.obs;
  final totalAverageTwoPoints = 0.0.obs;
  final highestVisitor = ''.obs;

  final excellent = 0.0.obs;
  final verySatisfactory = 0.0.obs;
  final satisfactory = 0.0.obs;
  final fair = 0.0.obs;
  final poor = 0.0.obs;
  final yes = 0.0.obs;
  final no = 0.0.obs;

  final officeName = 'questionsAdminsOffice';
  final officeNameUser = 'userAdminsOffice';
  final version = 0.obs;
  final listVersion = [].obs;
  final intervalNumber = 1.0.obs;

  final kFlutterHashtags = [].obs;

  final typeOfQuestionnaire = ''.obs;
  final eachNumAverageList = <QuestionAverage>[].obs;

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
      'AdminOfficeBarGraphController(_status: ${status.value} allQuestion: ${allQuestion.length}, eachNumAverageList: ${eachNumAverageList.length})';

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
      status,
      (value) async {
        switch (value) {
          case AdminOfficeBarGraphControllerStatus.error:
            MyLogger.printError(currentState());
            break;
          case AdminOfficeBarGraphControllerStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case AdminOfficeBarGraphControllerStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case AdminOfficeBarGraphControllerStatus.loaded:
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

    averageAlumni.value = 0;
    averageParent.value = 0;
    averageGuest.value = 0;
    averageStudent.value = 0;

    excellent.value = 0.0;
    verySatisfactory.value = 0.0;
    satisfactory.value = 0.0;
    fair.value = 0.0;
    poor.value = 0.0;
    yes.value = 0.0;
    no.value = 0.0;

    totalAverageFivePoints.value = 0;
    totalAverageTwoPoints.value = 0;

    eachNumAverageList.clear();
    kFlutterHashtags.clear();
  }

  void setInterval() {
    if (users.length < 10) {
      intervalNumber.value = 1;
    } else if (users.length > 10 && users.length <= 50) {
      intervalNumber.value = 5;
    } else if (users.length > 50 && users.length <= 100) {
      intervalNumber.value = 10;
    } else if (users.length > 100 && users.length <= 150) {
      intervalNumber.value = 15;
    } else if (users.length > 150 && users.length <= 200) {
      intervalNumber.value = 20;
    } else if (users.length > 200 && users.length <= 250) {
      intervalNumber.value = 25;
    } else if (users.length > 250 && users.length <= 300) {
      intervalNumber.value = 30;
    } else if (users.length > 300 && users.length <= 350) {
      intervalNumber.value = 35;
    } else if (users.length > 350 && users.length <= 400) {
      intervalNumber.value = 40;
    } else if (users.length > 400 && users.length <= 450) {
      intervalNumber.value = 45;
    } else if (users.length > 450 && users.length <= 500) {
      intervalNumber.value = 50;
    } else if (users.length > 500 && users.length <= 550) {
      intervalNumber.value = 55;
    } else if (users.length > 550 && users.length <= 600) {
      intervalNumber.value = 60;
    } else if (users.length > 600 && users.length <= 650) {
      intervalNumber.value = 65;
    } else if (users.length > 650 && users.length <= 700) {
      intervalNumber.value = 70;
    } else if (users.length > 700 && users.length <= 750) {
      intervalNumber.value = 75;
    } else if (users.length > 750 && users.length <= 800) {
      intervalNumber.value = 80;
    } else if (users.length > 800 && users.length <= 850) {
      intervalNumber.value = 85;
    } else if (users.length > 850 && users.length <= 900) {
      intervalNumber.value = 90;
    } else if (users.length > 900 && users.length <= 950) {
      intervalNumber.value = 95;
    } else if (users.length > 950 && users.length <= 1000) {
      intervalNumber.value = 100;
    } else if (users.length > 1000 && users.length <= 1050) {
      intervalNumber.value = 105;
    } else if (users.length > 1050 && users.length <= 1100) {
      intervalNumber.value = 110;
    } else if (users.length > 1100 && users.length <= 1150) {
      intervalNumber.value = 115;
    } else if (users.length > 1150 && users.length <= 1200) {
      intervalNumber.value = 120;
    } else if (users.length > 1200 && users.length <= 1250) {
      intervalNumber.value = 125;
    } else if (users.length > 1250 && users.length <= 1300) {
      intervalNumber.value = 130;
    } else if (users.length > 1300 && users.length <= 1350) {
      intervalNumber.value = 135;
    } else if (users.length > 1350 && users.length <= 1400) {
      intervalNumber.value = 140;
    } else if (users.length > 1400 && users.length <= 1450) {
      intervalNumber.value = 145;
    } else if (users.length > 1450 && users.length <= 1500) {
      intervalNumber.value = 150;
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
    getRemarksList();
  }

  Future<void> getUserTotals(String officeName) async {
    MyLogger.printInfo('getUserTotals');
    users.value = await UserRepository.getUsersAdminOfficeAnswered(
        office: officeName, version: version.value);

    MyLogger.printInfo('users.length : ${users.length}');

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
    computeAverage();
  }

  void computeAverage() {
    averageAlumni.value = totalAlumni.value / users.length;
    averageParent.value = totalParent.value / users.length;
    averageGuest.value = totalGuest.value / users.length;
    averageStudent.value = totalStudent.value / users.length;
    if (averageAlumni.value > averageParent.value &&
        averageAlumni.value > averageGuest.value &&
        averageAlumni.value > averageStudent.value) {
      highestVisitor.value = 'Alumni';
    }
    if (averageGuest.value > averageParent.value &&
        averageGuest.value > averageAlumni.value &&
        averageGuest.value > averageStudent.value) {
      highestVisitor.value = 'Guest';
    }
    if (averageParent.value > averageAlumni.value &&
        averageParent.value > averageGuest.value &&
        averageParent.value > averageStudent.value) {
      highestVisitor.value = 'Parent';
    }
    if (averageStudent.value > averageParent.value &&
        averageStudent.value > averageGuest.value &&
        averageStudent.value > averageAlumni.value) {
      highestVisitor.value = 'Student';
    }

    for (var i in allQuestion) {
      if (i.type == QuestionTypeEnum.fivePointsCase) {
        excellent.value += i.excellent;
        verySatisfactory.value += i.verySatisfactory;
        satisfactory.value += i.satisfactory;
        fair.value += i.fair;
        poor.value += i.poor;
        eachNumAverageList.add(QuestionAverage(
            question: i.question,
            average: (i.excellent * 5 +
                    i.verySatisfactory * 4 +
                    i.satisfactory * 3 +
                    i.fair * 2 +
                    i.poor) /
                users.length));
      }
      if (i.type == QuestionTypeEnum.twoPointsCase) {
        yes.value += i.yes;
        no.value += i.no;

        eachNumAverageList.add(QuestionAverage(
            question: i.question,
            average: (i.yes * 1 + i.no * 0) / users.length));
      }

      MyLogger.printError("ADDED DATA");
    }

    if (excellent.value != 0 ||
        verySatisfactory.value != 0 ||
        satisfactory.value != 0 ||
        fair.value != 0 ||
        poor.value != 0) {
      final totalAll = (excellent.value * 5 +
          verySatisfactory.value * 4 +
          satisfactory.value * 3 +
          fair.value * 2 +
          poor.value);
      if (totalAll != 0) {
        totalAverageFivePoints.value = totalAll /
            (excellent.value +
                verySatisfactory.value +
                satisfactory.value +
                fair.value +
                poor.value);
        typeOfQuestionnaire.value = 'Five Points Case';
      }
    }
    if (yes.value != 0 || no.value != 0) {
      totalAverageTwoPoints.value =
          (yes.value * 1 + no.value * 0) / (yes.value + no.value);
      typeOfQuestionnaire.value = 'Two Points Case';
    }
  }

  void getLatestVersion() async {
    status.value = AdminOfficeBarGraphControllerStatus.loading;

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
    status.value = AdminOfficeBarGraphControllerStatus.loading;

    try {
      allQuestion.value =
          await QuestionsRepository.getQuestions(officeName, version.value);
      status.value = AdminOfficeBarGraphControllerStatus.loaded;
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
          await RemarksRepository.getRemarksList('adminsOffice', version.value);
      addHashtagData(listRemarks);

      MyLogger.printInfo(currentState());
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> generatePdf(ScreenshotController controller) async {
    final image = await controller.capture();
    final pdf = pw.Document();

    // Convert the captured image to PDF
    if (image != null) {
      final imagePdf = pw.MemoryImage(image);
      pdf.addPage(pw.Page(
        build: (context) {
          return pw.Column(children: [
            pw.Text("Admins' Office"),
            pw.Image(imagePdf),
          ]);
        },
      ));

      final pdfBytes = await pdf.save();
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute(
            "download", "admins_office_questionnaire_${version.value}.pdf")
        ..click();
      html.Url.revokeObjectUrl(url);
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
