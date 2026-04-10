class VendorModel {
  final String id;
  final String name;
  final String phone;
  final String specialization;
  final double rating;

  VendorModel({
    required this.id,
    required this.name,
    required this.phone,
    this.specialization = "Expert Service Provider",
    this.rating = 4.8,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "Vendor",
      phone: json["phone"] ?? "",
      specialization: json["specialization"] ?? "Expert Service Provider",
      rating: (json["rating"] ?? 4.8).toDouble(),
    );
  }
}
