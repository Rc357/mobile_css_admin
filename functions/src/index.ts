
// Always update version of firebase-functions
// Run npm install --save firebase-functions@latest in functions directory

// To deploy a function run firebase deploy --only functions:sampleFunction
// To delete a function run firebase functions:delete sampleFunction
// IMPORTANT: DEPLOY OR DELETE 1 FUNCTION AT A TIME.
// NEVER DO A BULK DELETE OR BULK DEPLOY.

// Fix lint errors run npm run lint -- --fix

// To deploy functions locally via emulator run npm run serve
// To auto serve functions when change is detected run npm run build:watch


import * as admin from "firebase-admin";
admin.initializeApp();


import updateAdmin = require("./update_admin")

exports.updateAdminCredentials = updateAdmin.updateAdminCredentials;
