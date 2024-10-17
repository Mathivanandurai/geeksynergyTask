// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  String name;
  String email;
  String password;
  String phone;
  String profession;

  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.profession,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    profession: json["profession"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
    "profession": profession,
  };
}
