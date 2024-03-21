// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelUser({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String username;
  String email;
  String password;
  String fullname;
  DateTime tanggalInput;

  Datum({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.fullname,
    required this.tanggalInput,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        tanggalInput: DateTime.parse(json["tanggal_input"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "fullname": fullname,
        "tanggal_input": tanggalInput.toIso8601String(),
      };
}
