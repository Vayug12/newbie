const { body, param } = require("express-validator");
const asyncHandler = require("../utils/asyncHandler");
const validate = require("../middleware/validate");
const apiResponse = require("../utils/apiResponse");
const ApiFeatures = require("../utils/apiFeatures");
const Booking = require("../models/Booking");
const User = require("../models/User");
const Service = require("../models/Service");
const VendorProfile = require("../models/VendorProfile");
const { sendPushNotification } = require("../services/notificationService");
const { createOrder } = require("../services/paymentService");

const createBookingValidators = [
  body("vendorId").isMongoId(),
  body("serviceId").isMongoId(),
  body("date").notEmpty(),
  body("time").notEmpty(),
  validate
];

const statusValidators = [
  param("id").isMongoId(),
  body("status").isIn(["accepted", "rejected", "completed", "cancelled"]),
  validate
];

const createBooking = asyncHandler(async (req, res) => {
  const { vendorId, serviceId, date, time } = req.body;
  const [vendor, service] = await Promise.all([
    User.findById(vendorId),
    Service.findById(serviceId)
  ]);

  if (!vendor || !service) return apiResponse(res, 404, null, "Vendor or service not found");

  const booking = await Booking.create({
    userId: req.user._id,
    vendorId,
    serviceId,
    date,
    time,
    amount: service.price
  });

  const order = await createOrder({
    amount: service.price * 100,
    receipt: `booking_${booking._id}`
  });

  await sendPushNotification({
    token: vendor.fcmToken,
    title: "New booking request",
    body: `You have a new request for ${service.name}`,
    data: { bookingId: booking._id.toString() }
  });

  return apiResponse(res, 201, { booking, paymentOrder: order }, "Booking requested");
});

const getBookings = asyncHandler(async (req, res) => {
  const isVendorMode = req.user.activeMode === "vendor";
  const query = Booking.find(isVendorMode ? { vendorId: req.user._id } : { userId: req.user._id })
    .populate("serviceId")
    .populate("vendorId", "name phone");

  const features = new ApiFeatures(query, req.query);
  const { page, limit } = features.paginate();
  const items = await features.query.sort({ createdAt: -1 });

  return apiResponse(res, 200, {
    items,
    pagination: { page, limit, total: items.length }
  });
});

const updateBookingStatus = asyncHandler(async (req, res) => {
  const booking = await Booking.findById(req.params.id).populate("serviceId");
  if (!booking) return apiResponse(res, 404, null, "Booking not found");

  const nextStatus = req.body.status;
  const isVendor = booking.vendorId.toString() === req.user._id.toString();
  const isCustomer = booking.userId.toString() === req.user._id.toString();

  if ((nextStatus === "accepted" || nextStatus === "rejected" || nextStatus === "completed") && !isVendor) {
    return apiResponse(res, 403, null, "Only vendor can perform this action");
  }

  if (nextStatus === "cancelled" && !isCustomer) {
    return apiResponse(res, 403, null, "Only customer can cancel this booking");
  }

  booking.status = nextStatus;
  if (nextStatus === "completed") {
    booking.paymentStatus = "paid";
    await VendorProfile.updateOne(
      { userId: booking.vendorId },
      { $inc: { earnings: booking.amount } },
      { upsert: true }
    );
  }

  await booking.save();

  return apiResponse(res, 200, booking, "Booking status updated");
});

module.exports = {
  createBooking,
  getBookings,
  updateBookingStatus,
  createBookingValidators,
  statusValidators
};
