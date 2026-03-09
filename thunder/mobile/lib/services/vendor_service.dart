import "../core/api_endpoints.dart";
import "api_client.dart";

class VendorService {
  Future<Map<String, dynamic>> getVendors() {
    return ApiClient.get(ApiEndpoints.vendors);
  }

  Future<Map<String, dynamic>> getVendorById(String id) {
    return ApiClient.get("${ApiEndpoints.vendors}/$id");
  }

  Future<Map<String, dynamic>> getServices() {
    return ApiClient.get(ApiEndpoints.services);
  }
}
