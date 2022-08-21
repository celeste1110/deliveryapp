class ProductModel {
  ProductModel({
    required this.image,
    required this.categoryId,
    this.categoryDescription,
    required this.rate,
    required this.price,
    required this.name,
    required this.discount,
    required this.ingredients,
    required this.description,
    required this.time,
    required this.serving,
    this.id,
  });

  String image;
  String categoryId;
  String? categoryDescription;
  double rate;
  double price;
  String name;
  int discount;
  List<String> ingredients;
  String description;
  int time;
  int serving;
  String? id;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    image: json["image"],
    categoryId: json["category_id"],
    categoryDescription: json["category_description"]??'',
    rate: json["rate"].toDouble(),
    price: json["price"].toDouble(),
    name: json["name"],
    discount: json["discount"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    description: json["description"],
    time: json["time"],
    serving: json["serving"],
    id: json["id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "category_id": categoryId,
    "category_description": categoryDescription,
    "rate": rate,
    "price": price,
    "name": name,
    "discount": discount,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "description": description,
    "time": time,
    "serving": serving,
    "id": id,
  };
}