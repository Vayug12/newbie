const express = require("express");
const auth = require("../middleware/auth");
const {
  createReview,
  getVendorReviews,
  reviewValidators,
  vendorIdValidators
} = require("../controllers/reviewController");

const router = express.Router();

router.post("/", auth, reviewValidators, createReview);
router.get("/:vendorId", vendorIdValidators, getVendorReviews);

module.exports = router;
