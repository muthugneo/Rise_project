// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginWithOtpResponse loginWithOtpResponseFromJson(String str) =>
    LoginWithOtpResponse.fromJson(json.decode(str));

String loginWithOtpResponseToJson(LoginWithOtpResponse data) =>
    json.encode(data.toJson());

class LoginWithOtpResponse {
  LoginWithOtpResponse({
    this.result,
    this.message,
    this.otp,
    this.access_token,
    this.token_type,
    this.expires_at,
    this.user,
  });

  bool? result;
  String? message;
  String? otp;
  String? access_token;
  String? token_type;
  DateTime? expires_at;
  User? user;

  factory LoginWithOtpResponse.fromJson(Map<String, dynamic> json) =>
      LoginWithOtpResponse(
        result: json["result"],
        message: json["message"],
        otp: json["loginwithotp"].toString(),
        access_token:
            json["access_token"],
        token_type: json["token_type"],
        expires_at: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "otp": otp,
        "access_token": access_token,
        "token_type": token_type,
        "expires_at": expires_at == null ? null : expires_at?.toIso8601String(),
        "user": user == null ? null : user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.type,
    this.name,
    this.email,
    this.avatar,
    this.avatar_original,
    this.phone,
  });

  int? id;
  String? type;
  String? name;
  String? email;
  String? avatar;
  String? avatar_original;
  String? phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        avatar_original: json["avatar_original"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "email": email,
        "avatar": avatar,
        "avatar_original": avatar_original,
        "phone": phone,
      };
}
