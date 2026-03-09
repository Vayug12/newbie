const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    name: { type: String, trim: true },
    phone: { type: String, required: true, unique: true },
    email: { type: String, lowercase: true, trim: true },
    role: {
      type: String,
      enum: ["customer", "vendor", "both"],
      default: "customer"
    },
    activeMode: {
      type: String,
      enum: ["customer", "vendor"],
      default: "customer"
    },
    address: { type: String },
    location: {
      type: {
        type: String,
        enum: ["Point"],
        default: "Point"
      },
      coordinates: {
        type: [Number],
        default: [0, 0]
      }
    },
    fcmToken: { type: String }
  },
  { timestamps: true }
);

userSchema.index({ location: "2dsphere" });

module.exports = mongoose.model("User", userSchema);
