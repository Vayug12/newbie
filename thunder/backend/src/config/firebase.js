const admin = require("firebase-admin");
const path = require("path");
const fs = require("fs");

let initialized = false;

function initFirebase() {
  if (initialized) return admin;

  const serviceAccountPath = path.join(__dirname, "serviceAccountKey.json");
  
  try {
    if (fs.existsSync(serviceAccountPath)) {
      admin.initializeApp({
        credential: admin.credential.cert(require(serviceAccountPath))
      });
      console.log("Firebase Admin initialized using serviceAccountKey.json");
      initialized = true;
      return admin;
    }
  } catch (error) {
    console.error("Error loading serviceAccountKey.json:", error);
  }

  // Fallback to Env variables
  const projectId = process.env.FIREBASE_PROJECT_ID;
  const clientEmail = process.env.FIREBASE_CLIENT_EMAIL;
  const privateKey = process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, "\n");

  if (projectId && clientEmail && privateKey) {
    admin.initializeApp({
      credential: admin.credential.cert({ projectId, clientEmail, privateKey })
    });
    initialized = true;
    console.log("Firebase Admin initialized using env variables");
    return admin;
  }

  console.warn("Firebase Admin NOT initialized: Missing credentials");
  return null;
}

module.exports = initFirebase;

