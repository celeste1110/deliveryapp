
class UserModel {
  UserModel({
    this.id,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.role,
    required this.status,
  });

  String? id;
  String name;
  String lastname;
  String phone;
  String email;
  String role;
  bool status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    role: json["role"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "role": role,
    "status": status,
  };
}
