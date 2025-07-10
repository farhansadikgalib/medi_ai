
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? name;
  String? email;
  int? isAdmin;
  int? isDriver;
  String? token;
  String? message;
  String? status;

  LoginResponse({
    this.name,
    this.email,
    this.token,
    this.message,
    this.status,
    this.isAdmin,
    this.isDriver
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    name: json["name"] ?? '',
    email: json["email"] ?? '',
    isAdmin: json["is_admin"] ?? 0,
    isDriver: json["is_driver"] ?? 1,
    token: json["token"] ?? '',
    message: json["message"] ?? '',
    status: json["status"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "is_admin": isAdmin,
    "is_driver": isDriver,
    "token": token,
    "message": message,
    "status": status,
  };
}
