const express = require("express");
const { getVendors, getVendorById } = require("../controllers/vendorController");

const router = express.Router();

router.get("/", getVendors);
router.get("/:id", getVendorById);

module.exports = router;
