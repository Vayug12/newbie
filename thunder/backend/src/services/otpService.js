const crypto = require("crypto");

const otpStore = new Map();

function generateOTP(phone) {
  const otp = String(Math.floor(100000 + Math.random() * 900000));
  const expiresInMs = Number(process.env.OTP_EXPIRY_MINUTES || 5) * 60 * 1000;
  otpStore.set(phone, { otp, expiresAt: Date.now() + expiresInMs });
  return otp;
}

function verifyOTP(phone, otp) {
  const record = otpStore.get(phone);
  if (!record) return false;
  if (Date.now() > record.expiresAt) {
    otpStore.delete(phone);
    return false;
  }

  const valid = crypto.timingSafeEqual(Buffer.from(record.otp), Buffer.from(otp));
  if (valid) otpStore.delete(phone);
  return valid;
}

module.exports = { generateOTP, verifyOTP };
