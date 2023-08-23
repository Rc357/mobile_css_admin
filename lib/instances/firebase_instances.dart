import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firebaseAuth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final crashlytics = FirebaseCrashlytics.instance;
final functions = FirebaseFunctions.instanceFor(region: 'asia-southeast2');
final firebaseStorage = FirebaseStorage.instance;
