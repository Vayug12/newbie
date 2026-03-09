const { body, param } = require("express-validator");
const asyncHandler = require("../utils/asyncHandler");
const validate = require("../middleware/validate");
const apiResponse = require("../utils/apiResponse");
const Review = require("../models/Review");
const VendorProfile = require("../models/VendorProfile");

const reviewValidators = [
  body("vendorId").isMongoId(),
  body("rating").isInt({ min: 1, max: 5 }),
  body("comment").optional().isLength({ max: 500 }),
  validate
];

const vendorIdValidators = [param("vendorId").isMongoId(), validate];

const createReview = asyncHandler(async (req, res) => {
  const { vendorId, rating, comment } = req.body;
  const review = await Review.create({
    userId: req.user._id,
    vendorId,
    rating,
    comment
  });

  const stats = await Review.aggregate([
    { $match: { vendorId: review.vendorId } },
    {
      $group: {
        _id: "$vendorId",
        avgRating: { $avg: "$rating" },
        total: { $sum: 1 }
      }
    }
  ]);

  if (stats[0]) {
    await VendorProfile.updateOne(
      { userId: vendorId },
      { rating: Number(stats[0].avgRating.toFixed(1)), totalReviews: stats[0].total },
      { upsert: true }
    );
  }

  return apiResponse(res, 201, review, "Review submitted");
});

const getVendorReviews = asyncHandler(async (req, res) => {
  const reviews = await Review.find({ vendorId: req.params.vendorId })
    .populate("userId", "name")
    .sort({ createdAt: -1 });

  return apiResponse(res, 200, reviews);
});

module.exports = { createReview, getVendorReviews, reviewValidators, vendorIdValidators };
