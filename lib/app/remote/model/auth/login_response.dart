import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? message;
  bool? success;
  Data? data;
  String? token;

  LoginResponse({
    this.message,
    this.success,
    this.data,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"],
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data?.toJson(),
    "token": token,
  };
}

class Data {
  String? id;
  String? email;
  String? phoneNumber;
  String? mediid;
  String? owner;
  String? password;
  String? role;
  String? verificationToken;
  dynamic createdBy;
  int? v;

  Data({
    this.id,
    this.email,
    this.phoneNumber,
    this.mediid,
    this.owner,
    this.password,
    this.role,
    this.verificationToken,
    this.createdBy,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    mediid: json["mediid"],
    owner: json["owner"],
    password: json["password"],
    role: json["role"],
    verificationToken: json["verificationToken"],
    createdBy: json["createdBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "phoneNumber": phoneNumber,
    "mediid": mediid,
    "owner": owner,
    "password": password,
    "role": role,
    "verificationToken": verificationToken,
    "createdBy": createdBy,
    "__v": v,
  };
}
