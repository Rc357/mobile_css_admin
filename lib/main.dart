import 'package:admin/constants.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:admin/routes/app_pages.dart';
import 'package:admin/secrets/string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
        apiKey: AppSecrets().apiKey,
        appId: AppSecrets().appId,
        messagingSenderId: AppSecrets().messagingSenderId,
        projectId: AppSecrets().projectId,
        storageBucket: AppSecrets().storageBucket),
  );
  runApp(MyApp());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final hasChange = false.obs;
  final officeName = ''.obs;
  final version = 0.obs;
  _firestore
      .collection('notifications')
      .snapshots()
      .listen((QuerySnapshot snapshot) {
    snapshot.docChanges.forEach((change) {
      if (change.type == DocumentChangeType.added) {
        // Handle the new document here
        final data = change.doc.data() as Map;
        officeName.value = data['questionnaireVersion'];
        version.value = data['version'];

        hasChange.value = true;
        return;
      }
    });
    if (hasChange.value) {
      Get.snackbar(
        'Feedback',
        "Someone sent their feedback.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.notifications_active_outlined),
        onTap: (snack) async {
          print('Click');
          FirebaseAuth _auth = FirebaseAuth.instance;
          if (_auth.currentUser != null) {
            List<QuestionnaireVersionModel> dataReturn =
                await QuestionsRepository
                    .getQuestionnaireViaVersionAndOfficeName(
                        office: officeName.value, version: version.value);

            if (dataReturn.isNotEmpty) {
              if (officeName.value == 'questionnaireVersionLibrary') {
                Get.toNamed(AppPages.DASHBOARD_LIBRARY,
                    arguments: dataReturn[0]);
              }
              if (officeName.value == 'questionnaireVersionCashier') {
                Get.toNamed(AppPages.DASHBOARD_CASHIER,
                    arguments: dataReturn[0]);
              }
              if (officeName.value == 'questionnaireVersionRegistrar') {
                Get.toNamed(AppPages.DASHBOARD_REGISTRAR,
                    arguments: dataReturn[0]);
              }
              if (officeName.value == 'questionnaireVersionSecurityOffice') {
                Get.toNamed(AppPages.DASHBOARD_SECURITY,
                    arguments: dataReturn[0]);
              }
              if (officeName.value == 'questionnaireVersionAdminsOffice') {
                Get.toNamed(AppPages.DASHBOARD_ADMIN_OFFICE,
                    arguments: dataReturn[0]);
              }
            }
          }
        },
      );
      hasChange.value = false;
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobile CSS Admin',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          canvasColor: secondaryColor,
        ),
        home: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mobile CSS',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.indigo.shade800),
            useMaterial3: true,
          ),
          getPages: AppPages.routes,
          initialRoute: AppPages.SPLASH,
        ));
  }
}

// *update pub resources
// flutter pub get
// *run command
// flutter run -d chrome --web-renderer html
// *or
// flutter run -d chrome --web-renderer canvaskit
// *build command
// flutter build web
// *deploy command
// firebase deploy
// or this firebase deploy --only hosting:mobile-css-admin
// web URL  https://mobile-css-admin.web.app
