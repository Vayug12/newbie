const initFirebase = require("../config/firebase");

async function sendPushNotification({ token, title, body, data = {} }) {
  const admin = initFirebase();
  if (!admin || !token) return null;

  return admin.messaging().send({
    token,
    notification: { title, body },
    data
  });
}

module.exports = { sendPushNotification };
