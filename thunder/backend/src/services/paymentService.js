const Razorpay = require("razorpay");

let razorpayClient = null;

function getClient() {
  const keyId = process.env.RAZORPAY_KEY_ID;
  const keySecret = process.env.RAZORPAY_KEY_SECRET;

  const hasPlaceholder =
    keyId === "rzp_test_xxxxx" ||
    keySecret === "replace_secret" ||
    keyId?.startsWith("replace_") ||
    keySecret?.startsWith("replace_");

  if (!keyId || !keySecret || hasPlaceholder) {
    return null;
  }

  if (!razorpayClient) {
    razorpayClient = new Razorpay({
      key_id: keyId,
      key_secret: keySecret
    });
  }

  return razorpayClient;
}

async function createOrder({ amount, currency = "INR", receipt }) {
  const client = getClient();
  if (!client) {
    return { id: "mock_order_id", amount, currency, receipt };
  }

  return client.orders.create({ amount, currency, receipt });
}

module.exports = { createOrder };
