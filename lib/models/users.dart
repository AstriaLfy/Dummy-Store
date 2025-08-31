import 'package:meta/meta.dart';
import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;

  Product({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    role: json["role"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "role": role,
    "avatar": avatar,
  };
}
