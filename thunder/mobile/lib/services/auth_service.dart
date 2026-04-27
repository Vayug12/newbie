import "../core/api_endpoints.dart";
import "api_client.dart";

class AuthService {
  Future<Map<String, dynamic>> sendOtp(String phone) {
    return ApiClient.post(ApiEndpoints.login, {"phone": phone});
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp, {String? fcmToken}) {
    return ApiClient.post(ApiEndpoints.verifyOtp, {
      "phone": phone,
      "otp": otp,
      if (fcmToken != null) "fcmToken": fcmToken,
    });
  }

}
