import * as admin from "firebase-admin";
import * as firebaseFunctions from "firebase-functions";

const functions = firebaseFunctions.region("asia-southeast2");

export const updateAdminCredentials = functions.https.onCall(async (req, _) => {
  const {uid, newEmail, newPassword} = req.body;

  try {
    await admin.auth().updateUser(uid, {
      email: newEmail,
      password: newPassword,
    });

    return "ADMIN UPDATED SUCCESSFUL";
  } catch (error) {
    console.error("Error updating user:", error);
    return "ADMIN UPDATED FAILED";
  }
});
