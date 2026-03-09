import "package:razorpay_flutter/razorpay_flutter.dart";

class PaymentService {
  final Razorpay _razorpay = Razorpay();

  void openCheckout({required int amount, required String key, required String orderId}) {
    _razorpay.open({
      "key": key,
      "amount": amount,
      "name": "Service Marketplace",
      "order_id": orderId,
      "description": "Booking payment"
    });
  }

  void dispose() {
    _razorpay.clear();
  }
}
