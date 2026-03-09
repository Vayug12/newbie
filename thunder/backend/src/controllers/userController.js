const { body } = require("express-validator");
const asyncHandler = require("../utils/asyncHandler");
const validate = require("../middleware/validate");
const apiResponse = require("../utils/apiResponse");

const profileValidators = [
  body("name").optional().isLength({ min: 2 }),
  body("email").optional().isEmail(),
  body("role").optional().isIn(["customer", "vendor", "both"]),
  body("activeMode").optional().isIn(["customer", "vendor"]),
  validate
];

const getProfile = asyncHandler(async (req, res) => {
  return apiResponse(res, 200, req.user, "Profile fetched");
});

const updateProfile = asyncHandler(async (req, res) => {
  Object.assign(req.user, req.body);
  await req.user.save();
  return apiResponse(res, 200, req.user, "Profile updated");
});

module.exports = { getProfile, updateProfile, profileValidators };
