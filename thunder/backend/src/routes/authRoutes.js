const express = require("express");
const { login, verifyOtp, loginValidators, verifyOtpValidators } = require("../controllers/authController");

const router = express.Router();

router.post("/login", loginValidators, login);
router.post("/verify-otp", verifyOtpValidators, verifyOtp);

module.exports = router;
