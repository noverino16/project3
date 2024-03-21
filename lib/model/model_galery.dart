// To parse this JSON data, do
//
//     final modelGalery = modelGaleryFromJson(jsonString);

import 'dart:convert';

ModelGalery modelGaleryFromJson(String str) =>
    ModelGalery.fromJson(json.decode(str));

String modelGaleryToJson(ModelGalery data) => json.encode(data.toJson());

class ModelGalery {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelGalery({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelGalery.fromJson(Map<String, dynamic> json) => ModelGalery(
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
  String nama;
  String gambar;

  Datum({
    required this.id,
    required this.nama,
    required this.gambar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "gambar": gambar,
      };
}
