class CategoryModel {
  CategoryModel({
    this.id,
    required this.category,
    required this.status,
  });

  String? id;
  String category;
  bool status;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"] ?? "",
    category: json["category"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "status": status,
  };
}