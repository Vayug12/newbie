class VendorModel {
  final String id;
  final String name;
  final String phone;

  VendorModel({required this.id, required this.name, required this.phone});

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "Vendor",
      phone: json["phone"] ?? "",
    );
  }
}
