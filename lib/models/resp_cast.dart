import 'dart:convert';

import 'package:movieapp/models/cast.dart';

class RespCast {
  RespCast({
    required this.id,
    required this.cast,
  });

  int id;
  List<Cast> cast;

  factory RespCast.fromRawJson(String str) =>
      RespCast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RespCast.fromJson(Map<String, dynamic> json) => RespCast(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
      };
}
