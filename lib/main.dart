import 'package:admin/constants.dart';
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
