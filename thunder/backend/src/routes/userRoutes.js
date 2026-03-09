const express = require("express");
const auth = require("../middleware/auth");
const { getProfile, updateProfile, profileValidators } = require("../controllers/userController");

const router = express.Router();

router.get("/profile", auth, getProfile);
router.put("/profile", auth, profileValidators, updateProfile);

module.exports = router;
