const mongoose = require("mongoose");

const vendorProfileSchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true, unique: true },
    services: [{ type: mongoose.Schema.Types.ObjectId, ref: "Service" }],
    experience: { type: Number, default: 0 },
    rating: { type: Number, default: 0 },
    totalReviews: { type: Number, default: 0 },
    availability: [
      {
        day: String,
        slots: [String]
      }
    ],
    documents: [
      {
        name: String,
        url: String,
        verified: { type: Boolean, default: false }
      }
    ],
    earnings: { type: Number, default: 0 }
  },
  { timestamps: true }
);

module.exports = mongoose.model("VendorProfile", vendorProfileSchema);
