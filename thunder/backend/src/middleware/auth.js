const { verifyToken } = require("../services/jwtService");
const User = require("../models/User");

async function auth(req, res, next) {
  const header = req.headers.authorization;
  if (!header || !header.startsWith("Bearer ")) {
    return res.status(401).json({ success: false, message: "Unauthorized" });
  }

  try {
    const token = header.split(" ")[1];
    const decoded = verifyToken(token);
    const user = await User.findById(decoded.userId);
    if (!user) {
      return res.status(401).json({ success: false, message: "Invalid token" });
    }

    req.user = user;
    next();
  } catch (error) {
    return res.status(401).json({ success: false, message: "Token verification failed" });
  }
}

module.exports = auth;
