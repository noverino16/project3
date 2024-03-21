// To parse this JSON data, do
//
//     final modelInsertPegawai = modelInsertPegawaiFromJson(jsonString);

import 'dart:convert';

ModelInsertPegawai modelInsertPegawaiFromJson(String str) =>
    ModelInsertPegawai.fromJson(json.decode(str));

String modelInsertPegawaiToJson(ModelInsertPegawai data) =>
    json.encode(data.toJson());

class ModelInsertPegawai {
  int value;
  String message;

  ModelInsertPegawai({
    required this.value,
    required this.message,
  });

  factory ModelInsertPegawai.fromJson(Map<String, dynamic> json) =>
      ModelInsertPegawai(
        value: json["value"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
      };
}
