const asyncHandler = require("../utils/asyncHandler");
const apiResponse = require("../utils/apiResponse");
const ApiFeatures = require("../utils/apiFeatures");
const Service = require("../models/Service");

const getServices = asyncHandler(async (req, res) => {
  const query = Service.find();
  const features = new ApiFeatures(query, req.query);
  const { page, limit } = features.paginate();
  const [items, total] = await Promise.all([
    features.query,
    Service.countDocuments()
  ]);

  return apiResponse(res, 200, {
    items,
    pagination: { page, limit, total, totalPages: Math.ceil(total / limit) }
  });
});

const getServiceById = asyncHandler(async (req, res) => {
  const service = await Service.findById(req.params.id);
  if (!service) return apiResponse(res, 404, null, "Service not found");
  return apiResponse(res, 200, service);
});

module.exports = { getServices, getServiceById };
