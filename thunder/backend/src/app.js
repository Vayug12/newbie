const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");

const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes");
const serviceRoutes = require("./routes/serviceRoutes");
const vendorRoutes = require("./routes/vendorRoutes");
const bookingRoutes = require("./routes/bookingRoutes");
const reviewRoutes = require("./routes/reviewRoutes");
const { notFound, errorHandler } = require("./middleware/error");

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(morgan("dev"));

app.get("/health", (_, res) => res.json({ success: true, message: "API is healthy" }));

app.use("/api/v1/auth", authRoutes);
app.use("/api/v1/user", userRoutes);
app.use("/api/v1/services", serviceRoutes);
app.use("/api/v1/vendors", vendorRoutes);
app.use("/api/v1/bookings", bookingRoutes);
app.use("/api/v1/reviews", reviewRoutes);

app.use(notFound);
app.use(errorHandler);

module.exports = app;
