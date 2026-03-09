class ServiceModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final int duration;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.duration,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      category: json["category"] ?? "",
      price: (json["price"] ?? 0).toDouble(),
      duration: json["duration"] ?? 0,
    );
  }
}
