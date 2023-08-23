import 'package:admin/instances/firebase_instances.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> sendPasswordResetEmail({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  static Future<void> refreshFirebaseUser() async {
    await firebaseAuth.currentUser!.reload();
    await firebaseAuth.currentUser!.getIdToken(true);
  }

  static Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  static Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final currentUser = firebaseAuth.currentUser!;
    final credential = EmailAuthProvider.credential(
      email: currentUser.email!,
      password: currentPassword,
    );
    await currentUser.reauthenticateWithCredential(credential);
    await currentUser.updatePassword(newPassword);
  }
}
